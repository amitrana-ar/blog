**UBUNTU/Mac/Windows USER**

 1. Open terminal and type below command

    ```
    ssh-keygen -t ed25519
    ```
 2. Enter a file in which to save the key: Copy below string : 

    ```
    /home/kaval/.ssh/filename
    
    For Mac : /Users/$USER/.ssh/filename
    ```

    If it gives error replace $USER with your system's username
 3. Run below command : 

    ```
    nano ~/.ssh/config
    ```
 4. Copy below text in file : 

    ```
    Host github.com
        HostName github.com
        IdentityFile ~/.ssh/filename
    ```
 5. Press Ctrl + X and then Press Y to save file
 6. Now type below command

    ```
    cat ~/.ssh/filename.pub
    ```
 7. Copy exact text and add in your Github-Gitlab account
 8. Place where you need to add : Github-Gitlab Account > Select Profile > Preference > SSH Key > Add Key > Paste your key here
 9. Give Title : Your Name  
    Expiration date: Set date 2025-03-31
10. To verify connection, Open terminal and type below command  
    ssh -T git@github.com | gitlab.com  
    You will get message Welcome to Github-GitLa1

11. If any error connect your manager.

How you can update the URL in the repo?

1. In the terminal, navigate to the folder where the git project is stored.
2. Fire command - `git remote set-url origin <SSH_URL>`. This will replace the existing GitHub URL with the Hippo URL.
3. Now if you push code by - `git push`, will push to the Dhruv branch of the new Hippo URL.


