part of todo1;

///
/// this file contains:
/// [MessageType]
/// [ChatUser]
/// [ChatMessages]
/// [ChatMessage]
/// [ChatImage]
///
/// [ChatPage]
///

enum MessageType { text, image, sticker }

class ChatUser {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String aboutMe;

  const ChatUser(
      {required this.id,
      required this.photoUrl,
      required this.displayName,
      required this.phoneNumber,
      required this.aboutMe});
}

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  MessageType type;

  ChatMessages({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });
}

class ChatImage extends StatelessWidget {
  const ChatImage({
    super.key,
    required this.imageSrc,
    required this.onTap,
  });

  final String imageSrc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      child: Image.network(
        imageSrc,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
        loadingBuilder: FImageLoadingBuilder.style4,
        errorBuilder: FImageErrorWidgetBuilder.errorStyle1,
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    this.margin,
    this.color,
    this.colorText,
    required this.chatContent,
  });

  final String chatContent;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: KEdgeInsets.all_10,
      margin: margin,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: KBorderRadius.allCircular_10,
      ),
      child: Text(
        chatContent,
        style: TextStyle(fontSize: 16, color: colorText),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;
  final String userAvatar;

  const ChatPage({
    Key? key,
    required this.peerNickname,
    required this.peerAvatar,
    required this.peerId,
    required this.userAvatar,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String currentUserId;

  List<String> listMessages = [];

  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId = '';

  File? imageFile;
  bool isLoading = false;
  bool stickerShowed = false;
  String imageUrl = '';

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode
        .addFocusChangedListener(() => setState(() => stickerShowed = false));
    scrollController.addListener(_scrollListener);

    groupChatId = currentUserId.compareTo(widget.peerId) > 0
        ? '$currentUserId - ${widget.peerId}'
        : '${widget.peerId} - $currentUserId';
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() => _limit += _limitIncrement);
    }
  }

  void _callPhoneNumber(String phoneNumber) {
    throw UnimplementedError();
  }

  void showSticker() {
    focusNode.unfocus();
    setState(() => stickerShowed = !stickerShowed);
  }

  Future<bool> onBackPressed() {
    if (stickerShowed) {
      setState(() => stickerShowed = false);
    } else {}
    return Future.value(false);
  }

  void onSendMessage(String content, MessageType type) {
    if (content.isNotEmpty) {
      textController.clear();
      scrollController.animateTo(
        0,
        duration: KDuration.milli300,
        curve: Curves.easeOut,
      );
    }
  }

  bool checkIfMessageReceived(int index) {
    throw UnimplementedError();
  }

  bool checkIfMessageSent(int index) {
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.peerNickname),
        actions: [
          IconButton(
            onPressed: () async => _callPhoneNumber(""),
            icon: KIcon.phone,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: KEdgeInsets.symH_8,
          child: Column(children: [messageList, messageInput]),
        ),
      ),
    );
  }

  Widget get messageList => Flexible(
        child: groupChatId.isNotEmpty
            ? StreamBuilder<int>(
                stream: FStream.intOf(),
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data! % 5 == 0
                        ? ListView.builder(
                            padding: KEdgeInsets.all_10,
                            itemCount: snapshot.data!,
                            reverse: true,
                            controller: scrollController,
                            itemBuilder: (context, index) =>
                                messageListItemOf(index, snapshot.data!))
                        : const Center(child: Text('No messages...'))
                    : const Center(child: KProgressIndicator.circularBlueGrey),
              )
            : const Center(child: KIcon.accountCircleStyle1),
      );

  Widget messageListItemOf(int index, int number) {
    if (number == 0) {
      final chatMessages = ChatMessages(
        idFrom: 'idFrom',
        idTo: 'idTo',
        timestamp: 'timestamp',
        content: 'content',
        type: MessageType.text, // TODO
      );

      return number.isEven
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    chatMessages.type == MessageType.text
                        ? ChatMessage(
                            chatContent: chatMessages.content,
                            color: Colors.blue,
                            colorText: Colors.white,
                            margin: KEdgeInsets.onlyRight_10,
                          )
                        : chatMessages.type == MessageType.image
                            ? Container(
                                margin: KEdgeInsets.onlyRightTop_10,
                                child: ChatImage(
                                  imageSrc: chatMessages.content,
                                  onTap: kVoidCallback,
                                ),
                              )
                            : KSizedBox.shrink,
                    checkIfMessageSent(index)
                        ? Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: KBoxDecoration.circle,
                            child: Image.network(
                              widget.userAvatar,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              loadingBuilder: FImageLoadingBuilder.style1,
                              errorBuilder:
                                  FImageErrorWidgetBuilder.accountStyle2,
                            ),
                          )
                        : Container(width: 35),
                  ],
                ),
                checkIfMessageSent(index)
                    ? Container(
                        margin: KEdgeInsets.ltrb_50_6_0_8,
                        child: Text(
                          FDateTime.parseTimestampOf(chatMessages.timestamp),
                          style: KTextStyle.italicGrey_12,
                        ),
                      )
                    : KSizedBox.shrink,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    checkIfMessageReceived(index)
                        // left side (received message)
                        ? Container(
                            clipBehavior: Clip.hardEdge,
                            decoration:
                                KBoxDecorationBorderRadius.circularAll_20,
                            child: Image.network(
                              widget.peerAvatar,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              loadingBuilder: FImageLoadingBuilder.style3,
                              errorBuilder:
                                  FImageErrorWidgetBuilder.accountStyle2,
                            ),
                          )
                        : Container(width: 35),
                    chatMessages.type == MessageType.text
                        ? ChatMessage(
                            color: Colors.blueGrey,
                            colorText: Colors.white,
                            chatContent: chatMessages.content,
                            margin: KEdgeInsets.onlyLeft_10,
                          )
                        : chatMessages.type == MessageType.image
                            ? Container(
                                margin: KEdgeInsets.onlyLeftTop_100,
                                child: ChatImage(
                                  imageSrc: chatMessages.content,
                                  onTap: kVoidCallback,
                                ),
                              )
                            : KSizedBox.shrink,
                  ],
                ),
                checkIfMessageReceived(index)
                    ? Container(
                        margin: KEdgeInsets.ltrb_50_6_0_8,
                        child: Text(
                          FDateTime.parseTimestampOf(chatMessages.timestamp),
                          style: KTextStyle.italicGrey_12,
                        ),
                      )
                    : KSizedBox.shrink,
              ],
            );
    } else {
      return KSizedBox.shrink;
    }
  }

  Widget get messageInput => SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            Container(
              margin: KEdgeInsets.onlyRight_4,
              decoration: KBoxDecorationBorderRadius.circularAllGrey_10,
              child: const IconButton(
                onPressed: kVoidCallback,
                icon: KIcon.photo_28,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: TextField(
                focusNode: focusNode,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: textController,
                decoration:
                    KInputDecoration.style1.copyWith(hintText: 'write...'),
              ),
            ),
            Container(
              margin: KEdgeInsets.onlyLeft_4,
              decoration: KBoxDecorationBorderRadius.circularAllBlueGrey_30,
              child: IconButton(
                onPressed: () => onSendMessage(
                  textController.text,
                  MessageType.text,
                ),
                icon: KIcon.send,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
}
