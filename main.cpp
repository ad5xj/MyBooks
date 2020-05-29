#include <QGuiApplication>
#include <QSqlDatabase>
#include <QSqlError>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>

#include "titlessqlmodel.hpp"

void openDatabase()
{
    QSqlDatabase db;
    if ( !db.isValid() )
    {
        db = QSqlDatabase::addDatabase("QSQLITE","mybooksconn");
        db.setHostName("localhost");
        db.setDatabaseName("MyBooks.db");
        qDebug() << "Defining Database as"
                 << "\nDriver: " << db.driverName()
                 << "\nHost: " << db.hostName()
                 << "\nName:"  << db.databaseName();
    }
    if ( !db.open() )
    {
        qDebug() << "Database Open Error at " << Q_FUNC_INFO << __LINE__
                 << "\nErr:" << db.lastError().text();
    }

}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    openDatabase();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine appengine;
    QQuickStyle::setStyle("Fusion");

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    appengine.load(url);

    return app.exec();
}
