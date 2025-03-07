

This lab has an unprotected admin panel. It's located at an unpredictable location, but the location is disclosed somewhere in the application.

Solve the lab by accessing the admin panel, and using it to delete the user `carlos`.

## Step 1:
- Inspect the page using dev tools and search for **JS script tags** with any logic inside:
![[Pasted image 20250307041123.png]]

## Step 2:
- We found a script tag responsible for routing to the admin page logic:
	- the code chunk here uses the **isAdmin** variable to control routing to the admin page at the route `/admin-lngfe8` 
![[Pasted image 20250307041316.png]]





## Step 3:
- When we manually paste this route after the main URL we find that we are redirected to the admin page and we can delete users
![[Pasted image 20250307041556.png]]
![[Pasted image 20250307041700.png]]