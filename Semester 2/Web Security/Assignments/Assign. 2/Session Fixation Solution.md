# Attack Steps

## Step 1:
- Attacker opens his session and gets the session ID from the url
- ![[Pasted image 20250309001022.png]]
## Step 2:
- Attacker forces the victim to use the url with the same session id **(in this example we just copy the URL from the browser to another incognito browser)
 ![[Pasted image 20250309001143.png]]
## Step 3:
- Victim enters his credentials to access his profile
![[Pasted image 20250309001629.png]]
## Step 4:
- When the attacker refreshes he enters the same profile as it still has the same session id
![[Pasted image 20250309001644.png]]










# Vulnerability fix:

## Current logic

- The fix will be here in the login route where the session logic takes place
- we see that if the `session_id` variable is defined in sessions dictionary, it redirects us to `login_success` page, else it says `login_failed` page
- What we want to really do is to change the session id after the authentication that happens in line 39 in this way even when the attacker refreshes he will not enter the session as the victim will have a new session id which the attacker have no access to.![[Pasted image 20250309001857.png]]

## Fixed Logic
![[Pasted image 20250309002732.png]]

 The solution here is implemented in the following 3 lines:
```python
	# Generate new session ID
	new_session_id = os.urandom(16).hex()
	
	# Replace old Session ID with new one
	sessions[new_session_id] = sessions.pop(session_id)  
	
	# Redirect to the login success page with the new session ID
	return redirect(url_for('login', id=new_session_id))
```

- First we create a new session ID
- Then we replace it in the dictionary instead of the old session ID
- now this is already enough but we will have the old session ID in the url, to fix this we will change the id in url be redirecting to a new route with our new ID
