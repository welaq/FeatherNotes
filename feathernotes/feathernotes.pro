QT += core gui \
      xml \
      widgets \
      printsupport \
      x11extras \
      svg

TARGET = feathernotes
TEMPLATE = app
CONFIG += c++11

SOURCES += main.cpp\
           fn.cpp \
           find.cpp \
           domitem.cpp \
           dommodel.cpp \
           lineedit.cpp \
           x11.cpp \
           textedit.cpp \
           simplecrypt.cpp \
           vscrollbar.cpp \
           svgicons.cpp

HEADERS += fn.h \
           domitem.h \
           dommodel.h \
           textedit.h \
           lineedit.h \
           x11.h \
           spinbox.h \
           simplecrypt.h \
           vscrollbar.h \
           settings.h \
           help.h \
           filedialog.h \
           treeview.h \
           messagebox.h \
           svgicons.h

FORMS += fn.ui \
         helpDialog.ui \
         about.ui

RESOURCES += data/fn.qrc

unix:!macx: LIBS += -lX11

unix {
  #TRANSLATIONS
  exists($$[QT_INSTALL_BINS]/lrelease) {
    TRANSLATIONS = $$system("find data/translations/ -name 'feathernotes_*.ts'")
    updateqm.input = TRANSLATIONS
    updateqm.output = data/translations/translations/${QMAKE_FILE_BASE}.qm
    updateqm.commands = $$[QT_INSTALL_BINS]/lrelease ${QMAKE_FILE_IN} -qm data/translations/translations/${QMAKE_FILE_BASE}.qm
    updateqm.CONFIG += no_link target_predeps
    QMAKE_EXTRA_COMPILERS += updateqm
  }

  #VARIABLES
  isEmpty(PREFIX) {
    PREFIX = /usr
  }
  BINDIR = $$PREFIX/bin
  DATADIR =$$PREFIX/share

  DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

  #MAKE INSTALL

  target.path =$$BINDIR

  mime.path = $$DATADIR/mime/packages
  mime.files += ./data/$${TARGET}.xml

  desktop.path = $$DATADIR/applications
  desktop.files += ./data/$${TARGET}.desktop

  appIcon.path = $$DATADIR/icons/hicolor/scalable/apps
  appIcon.files += ./data/$${TARGET}.svg

  fileIcon.path = $$DATADIR/icons/hicolor/scalable/mimetypes
  fileIcon.files += ./data/text-feathernotes-fnx.svg

  trans.path = $$DATADIR/feathernotes
  trans.files += data/translations/translations

  INSTALLS += target mime desktop appIcon fileIcon trans
}
