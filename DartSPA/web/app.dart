part of dartspa;

class Application{
  final List<ToDo> ToDoList;
  final DivElement _rootElement;
  DivElement _contentElement;
  
  //Constructor
  Application(DivElement this._rootElement):
    ToDoList = new List<ToDo>();
  
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
    
    ButtonElement button = new ButtonElement();
    button.text = "Continue";
    button.onClick.listen((e) => ListView());
    _contentElement.children.add(button);
  }
  
  ClearView(){
    _contentElement.children.clear();
  }
  
  ListView(){
    ClearView();
    if(ToDoList.isEmpty){
      Element element = new Element.div();
          element.id = "list";
          element.className = "list";
          element.innerHtml = "There is no ToDo's in the list.";
          _contentElement.children.add(element);
          
          ButtonElement button = new ButtonElement();
              button.text = "Make one!";
              button.onClick.listen((e) => EditView());
              _contentElement.children.add(button);
    }else{
      TableElement table = new TableElement();
      var tHead = table.createTHead();
      TableRowElement headLine = tHead.insertRow(-1);
      headLine.insertCell(0).text = "Done";
      headLine.insertCell(1).text = "Title";
      headLine.insertCell(2).text = "Description";
      headLine.insertCell(3).text = "Details";
      
      var tBody = table.createTBody();
      for(int i = 0; i < ToDoList.length;  i++){
        TableRowElement newLine = tBody.insertRow(i);
        newLine.insertCell(0).innerHtml = ToDoList[i].done ? "<input type='checkbox' disabled checked>" : "<input type='checkbox' disabled>" ;
        newLine.insertCell(1).text = ToDoList[i].title;
        newLine.insertCell(2).text = ToDoList[i].description;
        newLine.insertCell(3).append(new ButtonElement()
        ..className = "editButton"
        ..text = "Edit"
        ..onClick.listen((e) => EditView(element: i))
        );
      }
      _contentElement.children.add(table);
      ButtonElement button = new ButtonElement();
                    button.text = "Add";
                    button.onClick.listen((e) => EditView());
                    _contentElement.children.add(button);
    }
  }
  
  EditView({int element: null}){
    ClearView();
    //If element is null, then it's a new todo. 
    if(element == null){
      LabelElement labelDone = new LabelElement();
      labelDone.text = "Done: ";
      _contentElement.children.add(labelDone);
      CheckboxInputElement done = new CheckboxInputElement();
      done.id = "done";
      done.checked = false;
      _contentElement.children.add(done);
      
      _contentElement.children.add(new Element.html('<br />'));
      LabelElement labelTitle = new LabelElement();
      labelTitle.text = "Title: ";
      _contentElement.children.add(labelTitle);
      TextAreaElement title =new TextAreaElement();
      title.id = "title";
      _contentElement.children.add(title);
     
      _contentElement.children.add(new Element.html('<br />'));
      LabelElement labelDescription = new LabelElement();
      labelDescription.text = "Description: ";
      _contentElement.children.add(labelDescription);
      TextAreaElement  description =new TextAreaElement();
      description.id = "description";
      _contentElement.children.add(description);
      
      _contentElement.children.add(new Element.html('<br />'));
      ButtonElement button = new ButtonElement();
      button.text = "Save";
      button.onClick.listen((e) => AddNewToDo());
      _contentElement.children.add(button);
    }else{
      var todo = ToDoList[element];
      LabelElement labelDone = new LabelElement();
            labelDone.text = "Done: ";
            _contentElement.children.add(labelDone);
            CheckboxInputElement done = new CheckboxInputElement();
            done.id = "done";
            done.checked = todo.done;
            _contentElement.children.add(done);
            
            _contentElement.children.add(new Element.html('<br />'));
            LabelElement labelTitle = new LabelElement();
            labelTitle.text = "Title: ";
            _contentElement.children.add(labelTitle);
            TextAreaElement title =new TextAreaElement();
            title.id = "title";
            title.text = todo.title;
            _contentElement.children.add(title);
           
            _contentElement.children.add(new Element.html('<br />'));
            LabelElement labelDescription = new LabelElement();
            labelDescription.text = "Description: ";
            _contentElement.children.add(labelDescription);
            TextAreaElement  description =new TextAreaElement();
            description.id = "description";
            description.text = todo.description;
            _contentElement.children.add(description);
            
            _contentElement.children.add(new Element.html('<br />'));
            ButtonElement button = new ButtonElement();
            button.text = "Save";
            button.onClick.listen((e) => EditExistingTodo(element));
            _contentElement.children.add(button);
    }
  }
  
  AddNewToDo(){
    CheckboxInputElement done = document.querySelector("#done");
    TextAreaElement  title = document.querySelector("#title");
    TextAreaElement description = document.querySelector("#description");
    
    ToDoList.add(new ToDo(done.checked, title.value, description.value));
    
    ListView();
  }
  
  EditExistingTodo(int element) {
    CheckboxInputElement done = document.querySelector("#done");
    TextAreaElement  title = document.querySelector("#title");
    TextAreaElement description = document.querySelector("#description");
    
    var todo = ToDoList[element];
    todo.done = done.checked;
    todo.title = title.value;
    todo.description = description.value;
    ToDoList.removeAt(element);
    ToDoList.add(todo);
    
    ListView();
  }
  
}