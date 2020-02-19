# cityaudioguide

## The Code
main.dart contains routes to the different parts of the app.

```
'/':(context) => HomeScreen(),
'/MapScreen':(context) => MapScreen(),
'/SearchScreen':(context) => SearchScreen(),
```

The initial route is '/' aka the HomeScreen (for testing purposes only).

```
initialRoute: '/',
```

HomeScreen contains buttons that will lead to the different parts of the application.

To reach another "page" using buttons use the onpressed() of the button to navigate to the other routes,

```
onPressed: () {Navigator.pushNamed(context, '/SearchScreen');}
```

This will push the new route page over the current page in a stack.

To remove the top most page from the stack (return to the previous page) do,

```
() {Navigator.pop(context);}
```
