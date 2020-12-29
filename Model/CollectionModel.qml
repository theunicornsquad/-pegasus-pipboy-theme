  import QtQuick 2.8

  ListModel {
    id: collectionList

    ListElement {
      name: "Game Boy"
      shortName: "gb"
      image: "gb.png"
      tags: "[gb]"
      year: "1989"
      description: "Nintendo's first handheld in the 'Game Boy' family."
    }
    ListElement {
      name: "Game Boy Advanced"
      shortName: "gba"
      image: "gba.png"
      tags: "[gba]"
      year: "2001"
      description: "Nintendo's second handheld in the 'Game Boy' family."
    }

    ListElement {
      name: "Game Boy Color"
      shortName: "gbc"
      image: "gbc.png"
      tags: "[gbc]"
      year: "1998"
      description: "Nintendo's third handheld in the 'Game Boy' family."
    }

    ListElement {
      name: "Nintendo 64"
      shortName: "n64"
      tags: "[n64]"
      image: "n64.png"
      year: "1997"
      description: "Nintendo's third console"
    }

    ListElement {
      name: "Sega Dreacast"
      shortName: "dreamcast"
      tags: "[dc][dreamcast]"
      image: "dreamcast.png"
      year: "1998"
      description: "The Dreamcast was Sega's final home console."
    }

    ListElement {
      name: "Sega MegaDrive"
      shortName: "megadrive"
      tags: "[megadrive][md]"
      image: "segacd.png"
      year: "1989"
      description: "Sega's second console."
    }
    ListElement {
      name: "Sony Playstation"
      shortName: "psx"
      tags: "[psx][playstation]"
      image: "psx.png"
      year: "1994"
      description: "Sony's first console"
    }

    ListElement {
      name: "Sony Playstation Portable"
      shortName: "psp"
      tags: "[psp]"
      image: "psp.png"
      year: "2002"
      description: "Sony's first handheld console"
    }

    ListElement {
      name: "Super Nintendo"
      shortName: "snes"
      tags: "[psx][plasytation]"
      image: "snes.png"
      year: "1990"
      description: "Nintendo's second console"
    }
  }