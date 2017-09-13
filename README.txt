The Ingredients Chef is an application that allows you to search for recipes that include ingredients that you have in store!

Network API used in the application is Spoonacular.

1)IngredientsTableViewController
2)AddIngredientTableViewController

When opening the application for the first time the user is prompted to add ingredients.

Click on the + button to add ingredients.Keep the checkmark only on those ingredients that you would like to have included in the recipe.
As soon as at least one ingredient is added the arrow button for moving to another view with suggested recipes appears on the screen.
All the added ingredients are persistent (Core Data)
Ingredients can be deleted from the list and the deletion will be persistent.

3)FoundRecipesCollectionViewController

The next screen will show a collection view of the found recipes( image + name), that are downloaded from the network.

While results are loading, a placeholder image and activity indicator are being shown.

Clicking on any of the cells will take the user to the next screen with the details for the recipe.

4)RecipeDetailsViewController

The view contains information about the cooking time, ingredients and detailed instructions for cooking and a larger picture. 
The is also a button in a shape of a heart, clicking on which will save the current recipe to the core data and will be shown in the Favorites. If the current recipe already exists in the favourites list, a red heart button will be shown and will be disabled.

Once the user clicks on the heart button the alert message is shown, stating that the recipe has been saved to the favorites. The image of the button changes to a red heart and becomes disabled.

5)FavoritesTableViewController

Favorites screen contains a table of recipes that were previously liked by the user. The information on this screen and the following (detailed screen) is persistent and can be deleted.


The app displays an alert view if error occurs while downloading the info from the Web.
