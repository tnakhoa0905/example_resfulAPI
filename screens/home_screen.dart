import 'package:example_resful_api/models/album.dart';
import 'package:example_resful_api/repo/repo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Repository repo = Repository();
  late TextEditingController _titleController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlbums();
    _titleController = TextEditingController();
  }

  void getAlbums() async {
    futureAlbum = await repo.fetchAllAlbum();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text('ResfulAPI'), actions: [
        IconButton(
            onPressed: () {
              openDialog();
            },
            icon: Icon(Icons.add))
      ]),
      body: ListView.builder(
          itemCount: futureAlbum.length,
          itemBuilder: ((context, index) => ListTile(
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    repo.deleteAlbum(futureAlbum[index].id.toString());
                    setState(() {
                      futureAlbum.removeAt(index);
                    });
                  },
                ),
                leading: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    openDialogUpdate(futureAlbum[index], index, context);
                  },
                ),
                title: Text('${futureAlbum[index].title}'),
              ))),
    ));
  }

  Future openDialogUpdate(Album album, int index, BuildContext ctx) {
    _titleController.text = album.title;
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Sửa Album'),
              content: TextField(
                  controller: _titleController,
                  autofocus: true,
                  decoration:
                      InputDecoration(hintText: 'Nhập công việc của bạn')),
              actions: [
                TextButton(
                    onPressed: () async {
                      await repo.updateAlbum(
                          _titleController.text, album.id, ctx);
                      setState(() {
                        futureAlbum[index].title = _titleController.text;
                      });
                      Navigator.of(context).pop();
                      _titleController.clear();
                    },
                    child: Text('Sửa'))
              ],
            ));
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Thêm Album'),
            content: TextField(
                controller: _titleController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Nhập album của bạn')),
            actions: [
              TextButton(
                  onPressed: () async {
                    await repo.createAlbum(_titleController.text);
                    setState(() {
                      // futureAlbum.add(result);
                    });
                    Navigator.of(context).pop();
                    _titleController.clear();
                  },
                  child: Text('Thêm'))
            ],
          ));
}
