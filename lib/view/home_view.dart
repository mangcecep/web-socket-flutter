import 'package:flutter/material.dart';
import 'package:web_socket_flutter/utils/constants.dart';
import 'package:web_socket_flutter/utils/services.dart';
import 'package:web_socket_flutter/view/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List data = [];
  final List<String> classes = ["X", "XI", "XII"];
  late String classValue = classes.first;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController major = TextEditingController();

  TextEditingController firstNameEdit = TextEditingController();
  TextEditingController lastNameEdit = TextEditingController();
  TextEditingController majorEdit = TextEditingController();
  late String classValueEdit = '';

  @override
  void initState() {
    super.initState();
    getDataFromAPI().then((onValue) async {
      setState(() => data = onValue['data']);
    });
  }

  Future<Map<String, dynamic>> getDataFromAPI() => Services().getData();

  onSubmit(context) {
    Services()
        .postData(classValue, major.text, firstName.text, lastName.text)
        .then((onResponse) {
      print("RESPON $onResponse");
      String message = onResponse['data']['message'].toString();

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(onResponse['status'] == 422 || onResponse['status'] == 401
              ? 'Error!!'
              : 'Success!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (onResponse['status'] == 401) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                  return;
                }
                onResponse['status'] == 422
                    ? null
                    : getDataFromAPI().then((onValue) async {
                        setState(() => data = onValue['data']);
                      });
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return SizedBox(
                    height: screenHeight,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: classValue.toString(),
                            onChanged: (val) =>
                                setState(() => classValue = val.toString()),
                            items: classes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4.0),
                              hintText: "First Name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(4.0),
                                hintText: "Last Name"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: major,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(4.0),
                                hintText: "Major"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                              elevation: 0,
                            ),
                            onPressed: () => onSubmit(context),
                            child: Text(
                              "Submit",
                              selectionColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
          },
          child: Icon(
            Icons.add,
          ),
        ),
        if (data.isEmpty) const Text('Loading'),
        for (int idx = 0; idx < data.length; idx++) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              color: Colors.amber[600],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("First Name: ${data[idx]['fname']}"),
                          Text("Last Name: ${data[idx]['lname']}"),
                          Text("Major: ${data[idx]['major']}"),
                          Text("Classes: ${data[idx]['classes']}"),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              firstNameEdit.text = data[idx]['fname'];
                              lastNameEdit.text = data[idx]['lname'];
                              majorEdit.text = data[idx]['major'];

                              setState(() {
                                classValueEdit = data[idx]['classes'];
                              });

                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return SizedBox(
                                      height: screenHeight,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: classValueEdit.toString(),
                                              onChanged: (val) => setState(() =>
                                                  classValueEdit =
                                                      val.toString()),
                                              items: classes.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: firstNameEdit,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(4.0),
                                                hintText: "First Name",
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: lastNameEdit,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(4.0),
                                                  hintText: "Last Name"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: majorEdit,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(4.0),
                                                  hintText: "Major"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.purpleAccent,
                                                elevation: 0,
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "Submit",
                                                selectionColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: Icon(Icons.edit)),
                        TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('Warning'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text("Are you sure?"),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Services()
                                            .deleteData(data[idx]['id'])
                                            .then((onValue) async {
                                          var code = onValue['status'];
                                          Navigator.of(context).pop();
                                          if (code == 401) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginView()),
                                            );
                                            return;
                                          }
                                          getDataFromAPI().then(
                                              (onValue) async => setState(() =>
                                                  data = onValue['data']));
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(Icons.delete)),
                      ],
                    ),
                  ]),
            ),
          ),
        ]
      ],
    );
  }
}
