### Transactional Database Requirements Task

**ER Diagram & Requirements (5pts) (due Sept. 17):** Document the requirements for your database in terms of "business rules" and draw an ER diagram for a database that reflects those requirements.  The files should be committed to your GitHub repo.

---

The assignment should include the following sections:

**Overview**:  Tell me what business domain the database pertains to. Check the textbook chapter but don't just give the chapter name. For example the "E-Commerce" chapter focuses particularly on clickstream and user session data (as opposed to online advertising or other things that might fall under e-commerce).

Example:

    This document describes the requirements for a database for a simple online auction site similar to eBay.  
    It includes buyers, sellers, items which fall into categories, and bids.
    
**Business Rules**:  Simple statements about data definitions, relationships, and constraints which will inform database design.  These are written in plain English.  They should be clear and brief.  You should identify at least 15-20.

Examples:

    A user may be both a buyer and a seller at the same time.
    An auction has a fixed start date and end date which do not change.
    An auction falls into a category based on the type of goods (e.g. Antiques).
    An auction may not be in two categories at once.
    There are three levels in the category hierarchy, no more or less.
    Buyers may place bids on an auction at any time between the start and end dates.
    A buyer makes only one bid on an auction, but he may change the bid amount at any time.
    The actual sale price is determined by a formula that sets it just higher than the second-highest bid.
    (...)

**ER Diagram**:  An ER diagram outlines the entities, attributes, and relationships necessary to model the data in accordance with the business rules you've identified.  The business rules you just identified should give you clues as to which relationships are one-to-one, one-to-many, etc., and which entities you need.  There are many different notations for these.  I recommend the "crow's foot" notation (Google it) and Gliffy.com as a diagram tool.

---

Upload the requirements document to your GitHub repo as a Markdown file (.md) and include the ER diagram as an image.  This will allow us to read it on the web and make changes easily.  More on Markdown syntax here:  https://help.github.com/articles/github-flavored-markdown
