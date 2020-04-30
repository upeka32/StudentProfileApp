import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterappfirebase/api.dart';
import 'package:flutterappfirebase/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './models/Student.dart';

void main() => runApp(BookApp());

class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        "/secondPage": (context) => FireBaseFireStoreDemo(),
        "/homePage": (context) => Home()
      },
    );
  }
}

class LoginPage extends StatefulWidget {
//  final FirebaseUser post;
//  LoginPage(this.post);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
       // padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/happy-student.png',
                width: 300, height: 300, fit: BoxFit.contain),
            Text(
              'SUNSHINE ENGLISH MEDIUM SCHOOL',
              style: TextStyle(
                decorationStyle: TextDecorationStyle.solid,
                fontStyle: FontStyle.normal,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            TextFormField(
              validator:(input){
                if(input.isEmpty){
                  return 'Please type an email';
                }
              },
              onSaved: (input)=> _email = input,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email, color: Colors.indigo),
              ),
            ),
            TextFormField(
              validator: (input){
                if(input.length < 6){
                  return 'Your password needs to be atleast 6 characters';
                }
              },
              onSaved: (input)=> _password = input,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open, color: Colors.indigo),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed:signIn ,
              color: Colors.indigo,
              child: Text('Sign In',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700
              ),),
            )
          ],
        ),
      ),
    );
  }
  Future<FirebaseUser> signIn() async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try {

        final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
        AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
        FirebaseUser user = result.user;

        print('USERRRR SUCCESSS'+ user.email);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(user: user)),
        );
      }catch (e){
            print(e.message+'777777777777777777');
      }
    }
  }
}

class Home extends StatefulWidget {

  const Home({Key key,this.user});
  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home',
          style: TextStyle(color: Colors.indigo)),
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.indigo),
        ),
        drawer: MainDrawer(),
        body: Container(
          color: Colors.white,
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Image.asset('assets/girl-icon.png',
                        width: 30, height: 30, fit: BoxFit.fitWidth),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 50, 10, 10),
                      child: Text('WELCOME ${widget.user.email}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.indigo)),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/unnamed.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed Profile');
                                      Navigator.pushNamed(context, '/');
                                    },
                                  ),
                                  Text(
                                    'Student Profile',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/Food-List-Ingredients-icon.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed List');
                                      Navigator.pushNamed(context, '/secondPage');
                                    },
                                  ),
                                  Text(
                                    'Student List',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/126425.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed Performance');
                                      Navigator.pushNamed(context, '/');
                                    },
                                  ),
                                  Text(
                                    'Performance',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: Center(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Image.asset(
                                        'assets/attendance-icon-png-7.png'),
                                    iconSize: 65,
                                    tooltip: 'Closes application',
                                    onPressed: () {
                                      print('Pressed Attendance');
                                      Navigator.pushNamed(context, '/');
                                    },
                                  ),
                                  Text(
                                    'Attendance',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class FireBaseFireStoreDemo extends StatefulWidget {

  FireBaseFireStoreDemo() : super();

  final String title = "Students List";

  @override
  FireBaseFireStoreDemoState createState() => FireBaseFireStoreDemoState();
}

class FireBaseFireStoreDemoState extends State<FireBaseFireStoreDemo> {

  bool _validate = false;
  bool showTextField = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController admissionController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController averageController = TextEditingController();

  bool isEditing = false;
  Student currentStudent;

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getStudents(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final student = Student.fromSnapshot(data);
    return Padding(
      key: ValueKey(student.admissionNo),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(student.name,style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.black,size: 30,),
            onPressed:  () {
              checkDelete(data);
            },
          ),
          onTap: () {
            //update
            setUpdateUI(student);
          },
        ),
      ),
    );
  }

  Future<void> checkDelete(DocumentSnapshot data) async {
    final student = Student.fromSnapshot(data);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))
            ),
          title: Text('Delete ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete.'),
               // Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                deleteStudent(student);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  setUpdateUI(Student student) {
    nameController.text = student.name;
    admissionController.text = student.admissionNo;
    mobileController.text = student.mobileNo;
    averageController.text = student.average;
    addressController.text = student.address;

    setState(() {
      showTextField = true;
      isEditing = true;
      currentStudent = student;
    });
  }

  add() {
    if (isEditing) {
      updateStudent(
          currentStudent,
          nameController.text,
          admissionController.text,
          mobileController.text,
          averageController.text,addressController.text);
      setState(() {
        isEditing = false;
      });
    } else {
      print("Before add");
      addStudent(nameController.text, admissionController.text,
          averageController.text, mobileController.text, addressController.text);
      print("Add successful");
    }
    addressController.text = '';
    averageController.text = '';
    mobileController.text = '';
    admissionController.text = '';
    nameController.text = '';
  }

  button() {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        child: Text(isEditing ? "UPDATE" : "ADD"),
        onPressed: () {
          add();
          checkAdd();
          setState(() {
            showTextField = false;
            admissionController.text.isEmpty ? _validate = true : _validate = false;
            nameController.text.isEmpty ? _validate=true : _validate = false;
            averageController.text.isEmpty ? _validate=true : _validate = false;
            mobileController.text.isEmpty ? _validate=true : _validate = false;
            addressController.text.isEmpty ? _validate=true : _validate = false;
          });
        },
      ),
    );
  }

  Future<void> checkAdd() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))
          ),
          //backgroundColor: Colors.blue,
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Student Added Successfully.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,size: 35,),
            onPressed: () {
              setState(() {
                showTextField = !showTextField;
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            showTextField
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          TextFormField(
                            controller: admissionController,
                            decoration: InputDecoration(
                                labelText: "Admission No",
                                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                hintText: "Enter Admission No"),
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                labelText: "Student Name",
                                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                hintText: "Enter Student Name"),
                          ),
                          TextFormField(
                            controller: mobileController,
                            decoration: InputDecoration(
                                labelText: "Mobile Number",
                                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                hintText: "Enter students mobile number"),
                            keyboardType: TextInputType.number,
                          ),

                          TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                                labelText: "Address",
                                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                hintText: "Enter students address"),
                          ),

                          TextFormField(
                            controller: averageController,
                            decoration: InputDecoration(
                                labelText: "Average",
                                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                hintText: "Enter students average"),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      button(),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            Text(
              "STUDENTS LIST",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: buildBody(context),
            ),
          ],
        ),
      ),
    );
  }
}
