import lustre
import lustre/element.{html}
import lustre/element/html.{div, button, p, text, h1}
import lustre/event

pub fn main() {
  let app = lustre.sandbox(init, update, view)
  lustre.start(app, "#app", Nil)
}

// 1. The Game State
pub type GameState {
  DarkRoom
  SunnyMeadow
}

fn init(_) {
  DarkRoom
}

// 2. The Game Actions
pub type Msg {
  GoThroughDoor
  GoBackInside
}

fn update(_state: GameState, msg: Msg) {
  case msg {
    GoThroughDoor -> SunnyMeadow
    GoBackInside -> DarkRoom
  }
}

// 3. The Web Interface
fn view(state: GameState) {
  case state {
    DarkRoom -> {
      div([], [
        h1([], [text("The Adventure Begins")]),
        p([], [text("You are standing in a cold, dark room. A heavy wooden door stands slightly ajar to the North.")]),
        button([event.on_click(GoThroughDoor)], [text("Go North through the door")])
      ])
    }
    SunnyMeadow -> {
      div([], [
        h1([], [text("The Great Outdoors")]),
        p([], [text("The sunlight blinds you for a moment. You stand in a beautiful, warm meadow full of wild flowers.")]),
        button([event.on_click(GoBackInside)], [text("Go back inside the dark room")])
      ])
    }
  }
}
