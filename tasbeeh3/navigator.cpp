#include "navigator.h"

Navigator::Navigator(QObject *parent) : QObject(parent)
{
    m_stack << "ZikrPage.qml";
}

void Navigator::push(const QString &page)
{
    m_stack << page;
    emit currentPageChanged(page);
}

void Navigator::pop()
{
    if (m_stack.size() > 1) {
        m_stack.removeLast();
        emit currentPageChanged(m_stack.last());
    }
}

bool Navigator::canPop() const
{
    return m_stack.size() > 1;
}
