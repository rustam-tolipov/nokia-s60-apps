#ifndef VIBRATIONHELPER_H
#define VIBRATIONHELPER_H

#include <QObject>

#ifdef Q_OS_SYMBIAN
#include <hwrmvibra.h>
#endif

class VibrationHelper : public QObject {
    Q_OBJECT
public:
    explicit VibrationHelper(QObject *parent = 0);
    ~VibrationHelper();
    Q_INVOKABLE void vibrate(int ms);
    Q_INVOKABLE bool isReady() const;

private:
#ifdef Q_OS_SYMBIAN
    CHWRMVibra *m_vibra;
#endif
};

#endif
