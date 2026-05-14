#include "store.h"
#include <QDate>
#include <QDir>

Store::Store(QObject *parent)
    : QObject(parent)
    , m_settings("TasbeehApp", "tasbeeh")
{
}

int  Store::counterSpeed() const { return m_settings.value("counterSpeed", 150).toInt();  }
bool Store::vibrationOn()  const { return m_settings.value("vibrationOn",  true).toBool(); }
int  Store::zikrTarget()   const { return m_settings.value("zikrTarget",   1000).toInt(); }
double Store::latitude()   const { return m_settings.value("coords/latitude",  41.2995).toDouble(); }
double Store::longitude()  const { return m_settings.value("coords/longitude", 69.2401).toDouble(); }

void Store::setCounterSpeed(int v)  { if (v == counterSpeed()) return; m_settings.setValue("counterSpeed", v); emit counterSpeedChanged(); }
void Store::setVibrationOn(bool v)  { if (v == vibrationOn())  return; m_settings.setValue("vibrationOn",  v); emit vibrationOnChanged();  }
void Store::setZikrTarget(int v)    { if (v == zikrTarget())   return; m_settings.setValue("zikrTarget",   v); emit zikrTargetChanged();   }
void Store::setLatitude(double v)   { if (v == latitude())     return; m_settings.setValue("coords/latitude",  v); emit coordsChanged(); }
void Store::setLongitude(double v)  { if (v == longitude())    return; m_settings.setValue("coords/longitude", v); emit coordsChanged(); }

void Store::vibrate(int ms) { Q_UNUSED(ms) }

void Store::save(int count, int round, int sessions) {
    m_settings.setValue("session/count",    count);
    m_settings.setValue("session/round",    round);
    m_settings.setValue("session/sessions", sessions);
    m_settings.sync();
}

QVariantMap Store::loadSession() {
    QVariantMap map;
    map["count"]    = m_settings.value("session/count",    0).toInt();
    map["round"]    = m_settings.value("session/round",    1).toInt();
    map["sessions"] = m_settings.value("session/sessions", 0).toInt();
    return map;
}

QString Store::prayerTime(const QString &name) const {
    return m_settings.value("prayer/" + name, "--:--").toString();
}

void Store::setPrayerTime(const QString &name, const QString &time) {
    m_settings.setValue("prayer/" + name, time);
    m_settings.sync();
}

QVariantMap Store::loadPrayerTimes() const {
    QVariantMap map;
    const char *keys[] = { "bomdod","quyosh","ishroq","peshin","asr","shom","xufton","taxajjud" };
    for (int i = 0; i < 8; i++) {
        QString k(keys[i]);
        map[k] = m_settings.value("prayer/" + k, "--:--").toString();
    }
    return map;
}

int Store::zikrCount(const QString &date) const {
    return m_settings.value("zikr/" + date, 0).toInt();
}

void Store::setZikrCount(const QString &date, int count) {
    m_settings.setValue("zikr/" + date, count);
    m_settings.sync();
}

QStringList Store::zikrDates(int days) const {
    QStringList list;
    QDate today = QDate::currentDate();
    for (int i = 0; i < days; i++) {
        QDate d = today.addDays(-i);
        QString key = d.toString("yyyy-MM-dd");
        if (m_settings.value("zikr/" + key, 0).toInt() > 0)
            list << key;
    }
    return list;
}

int Store::namazStatus(const QString &date, const QString &prayer) const {
    return m_settings.value("namazlog/" + date + "/" + prayer, 0).toInt();
}

void Store::setNamazStatus(const QString &date, const QString &prayer, int status) {
    int old = namazStatus(date, prayer);
    m_settings.setValue("namazlog/" + date + "/" + prayer, status);
    if (old != 2 && status == 2) {
        int bal = m_settings.value("qaza/balance/" + prayer, 0).toInt();
        m_settings.setValue("qaza/balance/" + prayer, bal + 1);
    } else if (old == 2 && status != 2) {
        int bal = m_settings.value("qaza/balance/" + prayer, 0).toInt();
        if (bal > 0) m_settings.setValue("qaza/balance/" + prayer, bal - 1);
    }
    m_settings.sync();
}

int Store::qazaBalance(const QString &prayer) const {
    return m_settings.value("qaza/balance/" + prayer, 0).toInt();
}

int Store::qazaPaid(const QString &prayer, const QString &date) const {
    return m_settings.value("qaza/paid/" + date + "/" + prayer, 0).toInt();
}

void Store::payQaza(const QString &prayer, const QString &date) {
    int bal = qazaBalance(prayer);
    if (bal <= 0) return;
    m_settings.setValue("qaza/balance/" + prayer, bal - 1);
    m_settings.setValue("qaza/paid/" + date + "/" + prayer, qazaPaid(prayer, date) + 1);
    m_settings.sync();
}

void Store::unpayQaza(const QString &prayer, const QString &date) {
    int paid = qazaPaid(prayer, date);
    if (paid <= 0) return;
    m_settings.setValue("qaza/paid/" + date + "/" + prayer, paid - 1);
    m_settings.setValue("qaza/balance/" + prayer, qazaBalance(prayer) + 1);
    m_settings.sync();
}

int Store::totalQazaBalance() const {
    const char *prayers[] = {"bomdod","peshin","asr","shom","xufton"};
    int total = 0;
    for (int i = 0; i < 5; i++)
        total += m_settings.value("qaza/balance/" + QString(prayers[i]), 0).toInt();
    return total;
}

QString Store::exportData() {
    QStringList candidates;
#ifdef Q_OS_SYMBIAN
    candidates << "E:\\tasbeeh_backup.ini" << "C:\\Data\\tasbeeh_backup.ini";
#else
    candidates << QDir::homePath() + "/tasbeeh_backup.ini";
#endif
    QStringList keys = m_settings.allKeys();
    foreach (const QString &path, candidates) {
        QSettings dst(path, QSettings::IniFormat);
        dst.clear();
        foreach (const QString &key, keys)
            dst.setValue(key, m_settings.value(key));
        dst.sync();
        if (dst.status() == QSettings::NoError)
            return path;
    }
    return QString();
}

QString Store::importData() {
    QStringList candidates;
#ifdef Q_OS_SYMBIAN
    candidates << "E:\\tasbeeh_backup.ini" << "C:\\Data\\tasbeeh_backup.ini";
#else
        candidates << QDir::homePath() + "/tasbeeh_backup.ini";
#endif
    foreach (const QString &path, candidates) {
        QSettings src(path, QSettings::IniFormat);
        if (src.status() != QSettings::NoError) continue;
        QStringList keys = src.allKeys();
        if (keys.isEmpty()) continue;
        foreach (const QString &key, keys)
            m_settings.setValue(key, src.value(key));
        m_settings.sync();
        return QString::number(keys.count());
    }
    return QString();
}

// Prayer times are set manually or imported from N8 via tasbeeh_backup.ini.
// Solar recalculation requires cmath functions unavailable on S60 3rd Edition.

QVariantMap Store::calculatePrayerTimes(double lat, double lon, const QDate &date) const {
    Q_UNUSED(lat) Q_UNUSED(lon) Q_UNUSED(date)
    return QVariantMap();
}

void Store::recalcToday() {
    emit prayerTimesChanged();
}
