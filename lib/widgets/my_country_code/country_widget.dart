import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_user/widgets/my_country_code/country_code_method.dart';
import 'package:karaz_user/widgets/text/headline3.dart';
import 'package:karaz_user/widgets/text/headline5.dart';
import 'package:karaz_user/widgets/text_field.dart';

class CountryCodeWidget extends GetView<CountryCodeMethod> {
  const CountryCodeWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(
            24,
          ),
          height: 618,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(
                    top: 21,
                    bottom: 16,
                  ),
                  child: Headline3(
                    title: 'Choose Country',
                  ),
                ),
                MainTextField(
                  controller: myCountryCodeMethod.countryTF.value,
                  hint: 'Search Here',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onChanged: (String value) {
                    myCountryCodeMethod.countries.value =
                        myCountryCodeMethod.searchNadCountry(value);
                    myCountryCodeMethod.countries.refresh();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: myCountryCodeMethod.countries.length,
                      itemBuilder: (BuildContext context, int indexPath) =>
                          Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                myCountryCodeMethod.setCountryCode(indexPath);
                              },
                              child: Container(
                                color: Colors.transparent,
                                margin: const EdgeInsets.only(
                                  bottom: 7,
                                  top: 7,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        0,
                                        12,
                                        0,
                                      ),
                                      child: myCountryCodeMethod.flagWidget(
                                        myCountryCodeMethod
                                            .countries[indexPath],
                                      ),
                                    ),
                                    Expanded(
                                      child: Headline5(
                                        title: myCountryCodeMethod
                                            .countries[indexPath]
                                            .nameTranslations['en']
                                            .toString(),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Headline5(
                                      title: myCountryCodeMethod
                                          .countries[indexPath].dialCode,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
