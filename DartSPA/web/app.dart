part of dartspa;

class Application{
  final DivElement _rootElement;
  DivElement _contentElement;
  
  //Constructor
  Application(DivElement this._rootElement);
  
  //Methods
  CreateUI(){
    var header = new Element.html('<header>Dart SPA</header>');
    _rootElement.children.add(header);
    
    _contentElement = new Element.div();
    _contentElement.id = "maincontent";
    _contentElement.className = "maincontent";
    _rootElement.children.add(_contentElement);
    
  }
  
  DefaultView(){
    Element element = new Element.div();
    element.id = "welcome";
    element.className = "welcome";
    element.innerHtml = "Welcome to this Dart single page application";
    _contentElement.children.add(element);
  }
  
}