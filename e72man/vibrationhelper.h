#ifndef VIBRATIONHELPER_H
#define VIBRATIONHELPER_H

#include <QObject>

class VibrationHelper : public QObject {
    Q_OBJECT
public:
    explicit VibrationHelper(QObject *parent = 0);
    Q_INVOKABLE void vibrate(int ms);
    Q_INVOKABLE bool isReady() const;
};

#endif
