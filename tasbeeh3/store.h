#ifndef STORE_H
#define STORE_H

#include <QObject>
#include <QSettings>
#include <QStringList>
#include <QVariantMap>
#include <QDate>

class Store : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int    counterSpeed READ counterSpeed WRITE setCounterSpeed NOTIFY counterSpeedChanged)
    Q_PROPERTY(bool   vibrationOn  READ vibrationOn  WRITE setVibrationOn  NOTIFY vibrationOnChanged)
    Q_PROPERTY(int    zikrTarget   READ zikrTarget   WRITE setZikrTarget   NOTIFY zikrTargetChanged)
    Q_PROPERTY(double latitude     READ latitude     WRITE setLatitude     NOTIFY coordsChanged)
    Q_PROPERTY(double longitude    READ longitude    WRITE setLongitude    NOTIFY coordsChanged)

public:
    explicit Store(QObject *parent = 0);

    int    counterSpeed() const;
    void   setCounterSpeed(int v);
    bool   vibrationOn()  const;
    void   setVibrationOn(bool v);
    int    zikrTarget()   const;
    void   setZikrTarget(int v);
    double latitude()     const;
    void   setLatitude(double v);
    double longitude()    const;
    void   setLongitude(double v);

    Q_INVOKABLE void        save(int count, int round, int sessions);
    Q_INVOKABLE QVariantMap loadSession();
    Q_INVOKABLE void        vibrate(int ms);

    Q_INVOKABLE QString     prayerTime(const QString &name) const;
    Q_INVOKABLE void        setPrayerTime(const QString &name, const QString &time);
    Q_INVOKABLE QVariantMap loadPrayerTimes() const;
    Q_INVOKABLE void        recalcToday();

    Q_INVOKABLE int         zikrCount(const QString &date) const;
    Q_INVOKABLE void        setZikrCount(const QString &date, int count);
    Q_INVOKABLE QStringList zikrDates(int days) const;

    Q_INVOKABLE QString     exportData();
    Q_INVOKABLE QString     importData();

    Q_INVOKABLE int  namazStatus(const QString &date, const QString &prayer) const;
    Q_INVOKABLE void setNamazStatus(const QString &date, const QString &prayer, int status);
    Q_INVOKABLE int  qazaBalance(const QString &prayer) const;
    Q_INVOKABLE int  totalQazaBalance() const;
    Q_INVOKABLE void payQaza(const QString &prayer, const QString &date);
    Q_INVOKABLE void unpayQaza(const QString &prayer, const QString &date);
    Q_INVOKABLE int  qazaPaid(const QString &prayer, const QString &date) const;

signals:
    void counterSpeedChanged();
    void vibrationOnChanged();
    void zikrTargetChanged();
    void coordsChanged();
    void prayerTimesChanged();

private:
    QSettings   m_settings;
    QVariantMap calculatePrayerTimes(double lat, double lon, const QDate &date) const;
};

#endif
