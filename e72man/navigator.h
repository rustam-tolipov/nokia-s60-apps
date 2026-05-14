#ifndef NAVIGATOR_H
#define NAVIGATOR_H

#include <QObject>
#include <QStringList>

class Navigator : public QObject {
    Q_OBJECT
public:
    explicit Navigator(QObject *parent = 0);
    Q_INVOKABLE void push(const QString &page);
    Q_INVOKABLE void pop();
    Q_INVOKABLE bool canPop() const;

signals:
    void currentPageChanged(const QString &page);

private:
    QStringList m_stack;
};

#endif
