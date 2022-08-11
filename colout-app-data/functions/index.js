const functions = require("firebase-functions");
var firebase = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");

firebase.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", { structuredData: true });
//   response.send("Hello from Firebase!");
// });

exports.helloWorld = functions.https.onRequest(async (req, res) => {
  let stuff = [];
  let db = getFirestore();
  let collection = await db.collection("droplet").get();
  for (doc of collection.docs) {
    colours = {};
    location = {};
    device = {};
    timezone = {};
    final = {};
    cquerySnapshot = {};
    dquerySnapshot = {};
    lquerySnapshot = {};
    tquerySnapshot = {};
    data = [];
    colSnapshot = await doc.ref
      .collection("colours")
      .orderBy("timestamp", "desc")
      .limit(1)
      .get()
      .then((cquerySnapshot) => {
        if (!cquerySnapshot.empty) {
          //We know there is one doc in the querySnapshot
          colours = {
            id: cquerySnapshot.docs[0].id,
            ...cquerySnapshot.docs[0].data(),
          };
        } else {
          return null;
        }
      });

    devSnapshot = await doc.ref
      .collection("device")
      .limit(1)
      .get()
      .then((dquerySnapshot) => {
        if (!dquerySnapshot.empty) {
          //We know there is one doc in the querySnapshot
          device = {
            id: dquerySnapshot.docs[0].id,
            ...dquerySnapshot.docs[0].data(),
          };
        } else {
          return null;
        }
      });

    locSnapshot = await doc.ref
      .collection("location")
      .get()
      .then((dquerySnapshot) => {
        if (!dquerySnapshot.empty) {
          location = [];
          for (ddoc of dquerySnapshot.docs) {
            multi_loc = {};
            //We know there is one doc in the querySnapshot
            multi_loc = {
              id: ddoc.id,
              ...ddoc.data(),
            };
            location.push(multi_loc);
          }
        } else {
          return null;
        }
      });

    tzSnapshot = await doc.ref
      .collection("timezone")
      .limit(1)
      .get()
      .then((tquerySnapshot) => {
        if (!tquerySnapshot.empty) {
          //We know there is one doc in the querySnapshot
          timezone = {
            id: tquerySnapshot.docs[0].id,
            ...tquerySnapshot.docs[0].data(),
          };
        } else {
          return null;
        }
      });

    final = {
      id: doc.id,
      ...doc.data(),
      colours,
      location,
      device,
      timezone,
    };
    stuff.push(final);

    // tempDoc.push({ id: doc.id, ...doc.data() });
  }
  console.log("stuff", JSON.stringify(stuff));
});
