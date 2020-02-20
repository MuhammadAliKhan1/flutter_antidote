import 'package:antidote/global.dart';
import 'package:antidote/models/inherited/user_therapist.dart';
import 'package:antidote/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User userData;
  User therapistData;
  ChatUser user = ChatUser();

  @override
  void initState() {
    super.initState();
  }

  void onSend(ChatMessage message) {
    var documentReference = Firestore.instance
        .collection(FireStoreKeys.messagesCollection)
        .document('${userData.email}-${therapistData.email}')
        .collection(FireStoreKeys.chatCollection)
        .document(DateTime.now().millisecondsSinceEpoch.toString());
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toJson(),
      );
    });
  }

  /* void uploadFile() async {
    File result = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxHeight: 400,
      maxWidth: 400,
    );

    if (result != null) {
      String id = Uuid().v4().toString();

      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child("chat_images/$id.jpg");

      StorageUploadTask uploadTask = storageRef.putFile(
        result,
        StorageMetadata(
          contentType: 'image/jpg',
        ),
      );
      StorageTaskSnapshot download = await uploadTask.onComplete;

      String url = await download.ref.getDownloadURL();

      ChatMessage message = ChatMessage(text: "", user: user, image: url);

      var documentReference = Firestore.instance
          .collection('messages')
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          message.toJson(),
        );
      });
    }
  }
 */
  @override
  Widget build(BuildContext context) {
    final UTData inheritedData = UTData.of(context);

    user.name = inheritedData.userData.name;
    user.uid = inheritedData.userData.email;
    user.avatar = inheritedData.userData.photoUrl;
    userData = inheritedData.userData;
    therapistData = inheritedData.therapistData;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dash Chat"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection(FireStoreKeys.messagesCollection)
            .document('${userData.email}-${therapistData.email}')
            .collection(FireStoreKeys.chatCollection)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          } else {
            List<DocumentSnapshot> items = snapshot.data.documents;
            var messages =
                items.map((i) => ChatMessage.fromJson(i.data)).toList();
            return DashChat(
              user: user,
              messages: messages,
              inputDecoration: InputDecoration(
                hintText: "Message here...",
                border: InputBorder.none,
              ),
              onSend: onSend,
            );
          }
        },
      ),
    );
  }
}
