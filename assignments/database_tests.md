### Database Tests Task

**Database Tests (5pts) (due Sept. 24):**  Write queries in SQL that *test* your database to make sure it does everything it's supposed to.  Update the requirements, ER diagram, and database creation code in GitHub if they need to change to make it work.  In the test script, use comments to tell me what each test is supposed to prove, and what output is expected.

---

For this assignment you need to "prove" that your database is structured correctly to reflect the business rules you intended.  (Or if the database is right and the business rules are wrong, you correct the business rules.)
The submission should be a file in your GitHub repository (preferably a .md file, but .docx is fine) which includes a number of screenshots.  Each screenshot should show a SQL query and its results.  In the file (or in the screenshot itself), include captions which tell me what you are trying to demonstrate.

For example: if the business rule is "no two customers can have the same e-mail address", you can prove it with two screenshots:
- one INSERT statement creates a customer with email address abc@xyz.com and *succeeds*
- another INSERT statement tries to create a customer with the same e-mail address and *fails* (screenshot shows the error message)

An acceptable example from some of your classmates can be seen here:  https://github.com/asu-cis-355/matrix/blob/master/testScreenshots.md
