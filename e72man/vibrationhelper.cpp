#include "vibrationhelper.h"

VibrationHelper::VibrationHelper(QObject *parent) : QObject(parent)
{
#ifdef Q_OS_SYMBIAN
    m_vibra = NULL;
    TRAP_IGNORE(m_vibra = CHWRMVibra::NewL());
#endif
}

VibrationHelper::~VibrationHelper()
{
#ifdef Q_OS_SYMBIAN
    delete m_vibra;
    m_vibra = NULL;
#endif
}

void VibrationHelper::vibrate(int ms)
{
#ifdef Q_OS_SYMBIAN
    if (m_vibra)
        TRAP_IGNORE(m_vibra->StartVibraL(ms));
#else
    Q_UNUSED(ms)
#endif
}

bool VibrationHelper::isReady() const
{
#ifdef Q_OS_SYMBIAN
    return m_vibra != NULL;
#else
    return false;
#endif
}
