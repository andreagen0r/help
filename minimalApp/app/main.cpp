// Qt
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QTranslator>
#include <QLocale>

// STL
#include <cassert>
#include <iostream>
#include <algorithm>
#include <filesystem>
#include <csignal>
#include <memory>

// 3rdParty
#include <magic_enum.hpp>

// Application
#include "applicationCLI.h"

// Backend
#include <awesome_core/log.h>

using namespace std::literals;

auto main( int argc, char* argv[] ) -> int {

    // Não deixa a aplicação dar crash caso perca conexão
    signal( SIGPIPE, SIG_IGN );

    QCoreApplication::setOrganizationName( u"MyCompany"_qs );
    QCoreApplication::setOrganizationDomain( u"com.mycompany"_qs );
    QCoreApplication::setApplicationName( u"AwesomeApp"_qs );
    QCoreApplication::setApplicationVersion( u"1.0"_qs );

    QGuiApplication app( argc, argv );

    cliInterface( app );

    Log();

    // ********************************************************************************************
    // Translate
    // ********************************************************************************************
    QTranslator translator;
    const auto uiLanguages = QLocale::system().uiLanguages();

    for ( const auto& locale : uiLanguages ) {
        const QString baseName = u"AwesomeApp_"_qs + QLocale( locale ).name();
        if ( translator.load( u":/i18n/"_qs + baseName ) ) {
            QGuiApplication::installTranslator( &translator );
            break;
        }
    }

    // ********************************************************************************************
    // Graphics backend setup
    // ********************************************************************************************
    QQuickWindow::setGraphicsApi( QSGRendererInterface::Vulkan );
    QQuickWindow::setTextRenderType( QQuickWindow::NativeTextRendering );

    // ********************************************************************************************
    // Appication
    // ********************************************************************************************
    QQmlApplicationEngine engine;
    engine.addImportPath( u":/"_qs );

    const QUrl url { u"qrc:/ModuleA/main.qml"_qs };

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url]( const QObject* obj, const QUrl& objUrl ) {
            if ( ( obj == nullptr ) && url == objUrl ) {
                constexpr int exitErrorCode { -1 };
                QCoreApplication::exit( exitErrorCode );
            }
        },
        Qt::QueuedConnection );

    engine.load( url );

    return QGuiApplication::exec();
}
