class OnBoards {
  final String text, image;

  OnBoards({required this.text, required this.image});
}

List<OnBoards> onBoardData = [
  OnBoards(
      text:
          'Hayvanları seviyorsanız ve onlara yardımcı olmak istiyorsanız, doğru yerdesiniz. Uygulamamızı keşfedin ve hayvanlara destek olmanın keyfini yaşayın!',
      image: "assets/images/dog.png"),
  OnBoards(
      text:
          "İhtiyaç sahibi hayvanları bulun ve onlara sevgi dolu bir yuva sağlayın.",
      image: "assets/images/cat.png"),
  OnBoards(
      text:
          "Hayvanlar hakkında daha fazla bilgi edinmek ve onlara yardım etmek için bilgilendirici içeriklerimize göz atın.",
      image: "assets/images/rabbit.png"),
];
