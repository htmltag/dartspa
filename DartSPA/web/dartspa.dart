library dartspa;

import 'dart:html';

//Parts of this application
part 'app.dart';
part 'models.dart';

void main() {
  var appContainer = document.querySelector("#dartspa");
  _app = new Application(appContainer);
  //app.AddToDo(false, "Todo", "What to do?");
  //app.AddToDo(true, "My Todo", "To do or not to do?");
  app.CreateUI();
  app.DefaultView();
}

/// top level setter and getter which holds the running application
Application _app;
Application get app => _app;
