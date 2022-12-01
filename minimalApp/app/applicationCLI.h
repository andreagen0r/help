#pragma once

#include <QGuiApplication>
#include <QCommandLineParser>

void cliInterface( const QGuiApplication& app ) {

    QCommandLineParser parser;
    parser.setApplicationDescription( u"CLI helper"_qs );
    parser.addHelpOption();
    parser.addVersionOption();
    parser.process( app );
}
