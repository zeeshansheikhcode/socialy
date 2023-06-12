//Showing Status
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../../models/story_model.dart';

class ShowStatus extends StatefulWidget {
  const ShowStatus({super.key, required this.showstories});
  final List<StoryModel> showstories;
  @override
  State<ShowStatus> createState() => _ShowStatusState();
}

class _ShowStatusState extends State<ShowStatus> {
 final storyController = StoryController();
 final List textStoryUser =[];
 final List photoStoryUser =[];
 final List videoStoryUser =[];
 final List<StoryItem> allStatus = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   for(int i =0 ; i< widget.showstories.length; i++)
   {
        if(widget.showstories[i].type.toString()== 'text')
        {
             
               allStatus.add(
                StoryItem.text(
                    key: UniqueKey(),
                title: widget.showstories[i].statusText.toString(),
                backgroundColor: Colors.blue,
                 ),
               );

        }
        if(widget.showstories[i].type.toString()== 'photo')
        {      
               allStatus.add(
                StoryItem.pageImage(
                    key: UniqueKey(),
                  controller: storyController,
                  url: widget.showstories[i].photoUrl.toString(),
                  caption: 'Image Status'             
                 ),
               );
        }    
    }
  }
  @override
  void dispose() {
    storyController.dispose();
    allStatus.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title:  Text(widget.showstories[0].useremail.toString()),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StoryView(
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
        storyItems: allStatus,
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
          Navigator.pop(context);
        },
        
      ),
    );
  }
}