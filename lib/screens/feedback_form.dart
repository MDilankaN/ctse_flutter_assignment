import 'package:ctse_assignment_1/screens/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';
import '../Controllers/QuestionController.dart';
import '../util/Quizes/quiz_crud_model.dart';

class FeedBackForm extends StatefulWidget {
  const FeedBackForm({Key? key}) : super(key: key);

  @override
  _FeedBackFormState createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {
  String? reviewSliderValue, TextFieldValue;
  final TextEditingController _textController = new TextEditingController();
  late final AnimationType animationType;
  late final Duration animationDuration;
  late final ShapeBorder alertBorder;
  late final bool isCloseButton;
  late final bool isOverlayTapDismiss;
  late final Color overlayColor;
  late final TextStyle titleStyle;
  late final TextStyle descStyle;
  late final EdgeInsets buttonAreaPadding;

  var alertStyle = AlertStyle(
    overlayColor: const Color.fromARGB(196, 151, 151, 163),
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: const TextStyle(
      color: Color.fromRGBO(91, 55, 185, 1.0),
      //fontSize: 10
    ),
  );

  void onChange1(int value) {
    print(value);
    if (value == 0) {
      setState(() {
        reviewSliderValue = 'Worst';
      });
    } else if (value == 1) {
      setState(() {
        reviewSliderValue = 'Worse';
      });
    } else if (value == 2) {
      setState(() {
        reviewSliderValue = 'Bad';
      });
    } else if (value == 3) {
      setState(() {
        reviewSliderValue = 'Good';
      });
    } else if (value == 4) {
      setState(() {
        reviewSliderValue = 'Best';
      });
    }
  }

  void onTextFieldChange(String value) {
    print(value);
    TextFieldValue = value;
  }

  void onPress() {
    print(reviewSliderValue);
    print(TextFieldValue);
    _textController.clear();
    Provider.of<QuizCrudModel>(context, listen: false)
        .insertFeedBack(reviewSliderValue, TextFieldValue)
        .then((value) {
      //Provider.of<QuizCrudModel>(context, listen: false).saveQuizID(value.toString()).;
      print(value);
      if (value != 0) {
        Alert(
          context: context,
          style: alertStyle,
          type: AlertType.success,
          //title: "",
          desc: "Thank You for the feedback",
          buttons: [
            DialogButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                MaterialPageRoute(builder: (context) => const ScorePage());
                Navigator.pop(context);

              },
              color: Color.fromRGBO(91, 55, 185, 1.0),
              radius: BorderRadius.circular(10.0),
            ),
          ],
        ).show();
        // Alert(
        //   context: context,
        //   title: "Successfully",
        //   desc: "You have Successfully Submitted the Data",
        // ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("FeedBack Form",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 30,
                      decoration: TextDecoration.none)),
            ),
            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(196, 151, 151, 163),
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            child: Text(
                              'What do you think of this app?',
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 10),
                            child: ReviewSlider(
                                onChange: onChange1,
                                initialValue: 2,
                                circleDiameter: 40,
                                optionStyle: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontSize: 12),
                                options: const [
                                  'Worst',
                                  'Worse',
                                  'Bad',
                                  'Good',
                                  'Best'
                                ]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Text(
                        'Do you have any thoughts of you would like to share?',
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: TextFormField(
                          controller: _textController,
                          onChanged: onTextFieldChange,
                          decoration: const InputDecoration(
                            hintText: 'Yes there',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              textStyle: TextStyle(fontSize: 15),
                              primary: Colors.blueGrey,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text('Submit'),
                            onPressed: onPress),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              textStyle: TextStyle(fontSize: 15),
                              primary: Colors.blueGrey,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text('Cancel'),
                            onPressed: () {}),
                      ],
                    )),
                  ],
                )),
            // Text(
            //     selectedValue1.toString(),
            //   style: TextStyle(fontSize: 1),
            // ),
            // SizedBox(height: 20),
            // Text(
            //   '¿Cómo fue la ayuda que recibiste?',
            //   style: TextStyle(color: Color(0xFF6f7478), fontSize: 18),
            // ),
            // SizedBox(height: 20),
            // ReviewSlider(
            //     optionStyle: TextStyle(
            //       color: Colors.red,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     onChange: onChange2,
            //     initialValue: 1,
            //     options: ['Terrible', 'Malo', 'Bien', 'Vale', 'Genial']),
            // Text(selectedValue2.toString()),
          ],
        ),
      ),
    );
  }
}
