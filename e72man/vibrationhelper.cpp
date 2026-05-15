#include "vibrationhelper.h"

VibrationHelper::VibrationHelper(QObject *parent) : QObject(parent) {}

void VibrationHelper::vibrate(int ms) { Q_UNUSED(ms) }

bool VibrationHelper::isReady() const { return false; }
