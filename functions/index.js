/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const { GraphQLClient } = require("graphql-request");

function getHasuraClient() {
    const hasuraAdminSecret = process.env.HASURA_ADMIN_SECRET;
    if (!hasuraAdminSecret) {
      throw new Error("HASURA_ADMIN_SECRET must be configured for Firebase Functions");
    }

    return new GraphQLClient(
      process.env.HASURA_GRAPHQL_ENDPOINT ||
        "https://artistic-reptile-32.hasura.app/v1/graphql",
      {
        headers: {
          "content-type": "application/json",
          "x-hasura-admin-secret": hasuraAdminSecret,
        },
      },
    );
}

admin.initializeApp();

exports.registerUser = functions.https.onCall(async (data) => {
 const email = data.email;
 const password = data.password;
 const displayName = data.displayName;

 if (email == null || password == null || displayName == null){
   throw new functions.https.HttpsError('invalid-argument', 'missing information');
 }

 try {
    //logic:
    //HOW FRONTEND SENDS DATA TO BACKEND_
    //    access access
    //adimin=>auth=>createUser(firebase)
    var userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      displayName: displayName
    });

    const customClaims = {
        "https://hasura.io/jwt/claims": {
            "x-hasura-user-id": userRecord.uid,
            "x-hasura-allowed-roles": ["user"],
            "x-hasura-default-role": "user"
        }
    };
    
    await admin.auth().setCustomUserClaims(userRecord.uid, customClaims);

    return userRecord.toJSON();

 }catch (error) {
    throw new functions.https.HttpsError('internal', 'Unable to register user');

 }

});

exports.processSignUp = functions.auth.user().onCreate(async (user) => {
  // Implementation for processing sign-up
  const id = user.uid;
  const email = user.email;
  const name = user.displayName || "NO NAME";

  const mutation = `mutation($id: String!, $email: String!, $name: String!) {
    insert_user(objects: [{
    id: $id,
    email: $email,
    name: $name
    }]) {
    affected_rows
    }
}`;
try {
    const data = await getHasuraClient().request(mutation, {
        id: id,
        email: email,
        name: name
    })
    return data;

} catch (error) {
    throw new Error('Unable to synchronize user creation with Hasura');
}


});
exports.updateUserName = functions.https.onCall(async (data) => {
  const { id, name } = data;

  if (typeof id !== "string" || typeof name !== "string" || !name.trim()) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "id and name are required",
    );
  }

  const mutation = `mutation($id: String!, $name: String!) {
    update_user(where: {id: {_eq: $id}}, _set: {name: $name}) {
      affected_rows
    }
  }`;

  try {
    return await getHasuraClient().request(mutation, { id, name: name.trim() });
  } catch (error) {
    throw new functions.https.HttpsError("internal", "Unable to update user name");
  }
});

exports.processDelete = functions.auth.user().onDelete(async (user) => {
  const mutation = `mutation($id: String!) {
    delete_user(where: {id: {_eq: $id}}) {
      affected_rows
    }
  }`;

  try {
    return await getHasuraClient().request(mutation, { id: user.uid });
  } catch (error) {
    throw new Error("Unable to synchronize user deletion with Hasura");
  }
});