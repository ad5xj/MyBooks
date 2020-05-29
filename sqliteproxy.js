
/* Java Script to interface to SQLite Database */
/* Create and initialize the database */
function initDB()
{
    console.debug("Opening Database")
    var db = LocalStorage.openDatabaseSync("MyBooks.db", "1.0", "MyBooks Database", 1000000);
    try {
        db.transaction(
            function(tx)
            {
                tx.executeSql('CREATE TABLE IF NOT EXISTS UserDetails(username TEXT, password TEXT, hint TEXT)');
            }
        )
        return db;
    }
    catch(err) {
        console.log("Error on open:" + qsTr(err))
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("MyBooks.db", "", "Local Storage handle", 1000000)
    }
    catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbReadAll()
{
    var db = dbGetHandle()
    var strDML = "SELECT Books.ID as idno, Books.AuthKey, Books.MediaKey, Books.Title as title, Authors.LastName||', "
    strDML = strDML + "'||Authors.FirstName as author, MediaType.Media as media, "
    strDML = strDML + "Books.Notes as notes "
    strDML = strDML + "FROM Books "
    strDML = strDML + "LEFT JOIN Authors   ON Books.AuthKey  = Authors.ID "
    strDML = strDML + "LEFT JOIN MediaType ON Books.MediaKey = MediaType.ID "
    strDML = strDML + "ORDER BY Books.Title ASC, Authors.LastName ASC, Authors.FirstName ASC "
    db.transaction(function (tx) {
        var results = tx.executeSql(strDML)

        for (var i = 0; i < results.rows.length; i++)
        {
            titlesListModel.append(
            {
                idno: results.rows.item(i).rowid,
                selected: results.rows.item(i).selected,
                title: results.rows.item(i).title,
                author: results.rows.item(i).author,
                media: results.rows.item(i).media,
                note: results.rows.item(i).notes
            })
        }
    })
}

/* Register New user */
function registerNewUser(uname, pword, pword2, hint)
{
    var ret  = Backend.validateRegisterCredentials(uname, pword, pword2, hint)
    var message = ""
    switch(ret)
    {
    case 0: message = "Valid details!"
        break;
    case 1: message = "Missing credentials!"
        break;
    case 2: message = "Password does not match!"
        break;
    }

    if(0 !== ret)
    {
        popup.popMessage = message
        popup.open()
        return
    }

    dataBase.transaction(function(tx) {
        var results = tx.executeSql('SELECT password FROM UserDetails WHERE username=?;', uname);
        if(results.rows.length !== 0)
        {
            popup.popMessage = "User already exist!"
            popup.open()
            return
        }
        tx.executeSql('INSERT INTO UserDetails VALUES(?, ?, ?)', [ uname, pword, hint ]);
        showUserInfo(uname) // goto user info page
    })
}

/* Login users */
function loginUser(uname, pword)
{
    var ret  = Backend.validateUserCredentials(uname, pword)
    var message = ""
    if(ret)
    {
        message = "Missing credentials!"
        popup.popMessage = message
        popup.open()
        return
    }

    dataBase.transaction(function(tx) {
        var results = tx.executeSql('SELECT password FROM UserDetails WHERE username=?;', uname);
        if(results.rows.length === 0)
        {
            message = "User not registered!"
            popup.popMessage = message
            popup.open()
        }
        else if(results.rows.item(0).password !== pword)
        {
            message = "Invalid credentials!"
            popup.popMessage = message
            popup.open()
        }
        else
        {
            console.log("Loginess!")
            showUserInfo(uname)
        }
    })
}

// Retrieve password using password hint
function retrievePassword(uname, phint)
{
    var ret  = Backend.validateUserCredentials(uname, phint)
    var message = ""
    var pword = ""
    if(ret)
    {
        message = "Missing credentials!"
        popup.popMessage = message
        popup.open()
        return ""
    }

    dataBase.transaction(function(tx) {
        var results = tx.executeSql('SELECT password FROM UserDetails WHERE username=? AND hint=?;', [uname, phint]);
        if(results.rows.length === 0)
        {
            message = "User not found!"
            popup.popMessage = message
            popup.open()
        }
        else
        {
            pword = results.rows.item(0).password
        }
    })
    return pword
}

// Show UserInfo page
function showUserInfo(uname)
{
    stackView.replace("qrc:/UserInfoPage.qml", {"userName": uname})
}

// Logout and show login page
function logoutSession()
{
    stackView.replace("qrc:/LogInPage.qml")
}

// Show Password reset page
function forgotPassword()
{
    stackView.replace("qrc:/PasswordResetPage.qml")
}
