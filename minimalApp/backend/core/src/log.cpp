#include "log.h"
#include <QDebug>

Log::Log() {
    qInfo() << u"Awesome Log"_qs;
}
