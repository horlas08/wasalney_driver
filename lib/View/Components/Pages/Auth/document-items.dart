import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Logic/Controllers/app-controller.dart';
import '../../../../Logic/Controllers/user-controller.dart';
import '../../../../Public/api-urls.dart';
import '../../../../Public/images.dart';
import 'document-box.dart';
class DocumentItem extends StatefulWidget {
  const DocumentItem({Key? key}) : super(key: key);

  @override
  State<DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    UserController.user.value.document.value!=null?

    Column(
      children: [
        UserController.user.value.document.value.onCarCard!=null?
        DocumentBox(
          condition: true,
          isNetwork: true,
          loadingName: 'update-Document1',
          // text: 'عکس روی کارت وسیله نقلیه',
          text: '${AppController.of(context)!.value('photo on vehicle card')}',
          pathImage:basePathImgMain+UserController.user.value.document.value.onCarCard! ,
          onChange: (img)async{
            await UserController.updateDoc1(img);
            setState(() {

            });
          },
        ) :DocumentBox(
          // text: 'بارگذاری عکس روی کارت وسیله نقلیه',
          text: '${AppController.of(context)!.value('upload photo on vehicle card')} *',
          pathImage:document_upload_icon,
          loadingName:  'update-Document1',

          onChange: (img)async{
            await UserController.updateDoc1(img);
            setState(() {

            });
          },
        ),
        UserController.user.value.document.value.backCarCard!=null?
        DocumentBox(
          condition: true,
          isNetwork: true,
          loadingName:  'update-Document2',
          // text: ' عکس پشت کارت وسیله نقلیه',
          text: '${AppController.of(context)!.value('photo on the back of the vehicle card')}',
          pathImage:basePathImgMain+UserController.user.value.document.value.backCarCard!,
          onChange: (img)async{
            await UserController.updateDoc2(img);
            setState(() {

            });
          },
        ) :DocumentBox(
          // text: ' بارگذاری پشت کارت وسیله نقلیه',
          text: '${AppController.of(context)!.value('upload on the back of the vehicle card')} *',
          pathImage:document_upload_icon,
          loadingName:  'update-Document2',

          onChange: (img)async{
            await UserController.updateDoc2(img);
            setState(() {

            });
          },
        ),
        UserController.user.value.document.value.onCertificate!=null?
        DocumentBox(
          condition: true,
          isNetwork: true,
          loadingName:  'update-Document3',

          // text: 'عکس گواهینامه',
          text: '${AppController.of(context)!.value('certificate photo')} ',
          pathImage:basePathImgMain+UserController.user.value.document.value.onCertificate!,
          onChange: (img)async{
            await UserController.updateDoc3(img);
            setState(() {

            });
          },
        ): DocumentBox(
          // text: 'بارگذاری عکس گواهینامه ',
          text: '${AppController.of(context)!.value('upload a photo of the certificate')} *',
          pathImage:document_upload_icon,
          loadingName:  'update-Document3',

          onChange: (img)async{
            await UserController.updateDoc3(img);
            setState(() {

            });
          },
        ),
        UserController.user.value.document.value.docAddition!=null?
        DocumentBox(
          condition: true,
          isNetwork: true,
          loadingName:  'update-Document3',

          // text: 'عکس گواهینامه',
          text: '${AppController.of(context)!.value('document additional')}',
          pathImage:basePathImgMain+UserController.user.value.document.value.docAddition!,
          onChange: (img)async{
            await UserController.updateDoc4(img);
            setState(() {

            });
          },
        ): DocumentBox(
          // text: 'بارگذاری عکس گواهینامه ',
          text: '${AppController.of(context)!.value('document additional')}',
          pathImage:document_upload_icon,
          loadingName:  'update-Document4',

          onChange: (img)async{
            await UserController.updateDoc4(img);
            setState(() {

            });
          },
        ),
      ],
    ):Column(
      children: [
        DocumentBox(
          condition: false,
          isNetwork: true,
          loadingName:  'update-Document1',
          text: '${AppController.of(context)!.value('upload photo on vehicle card')} *',
          pathImage:document_upload_icon,
          onChange: (img)async{
            await UserController.updateDoc1(img);
            setState(() {

            });
          },
        ) ,
        DocumentBox(
          text: '${AppController.of(context)!.value('upload on the back of the vehicle card')} *',
          pathImage:document_upload_icon,
          loadingName:  'update-Document2',
          onChange: (img)async{
            await UserController.updateDoc2(img,);
            setState(() {

            });
          },
        ),
        DocumentBox(
          text: '${AppController.of(context)!.value('upload a photo of the certificate')} *',
          pathImage:document_upload_icon,
          loadingName:  'update-Document3',
          onChange: (img)async{
            await UserController.updateDoc3(img);
            setState(() {

            });
          },
        ),
        DocumentBox(
          text: '${AppController.of(context)!.value('document additional')}',
          pathImage:document_upload_icon,
          loadingName:  'update-Document4',
          onChange: (img)async{
            await UserController.updateDoc4(img);
            setState(() {

            });
          },
        ),
      ],
    ));
  }
}
