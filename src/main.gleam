import lustre
import lustre/component
import lustre/element.{type Element}
import lustre/element/html

// 1. THE STATE (MODEL)
// Define what data your game needs to keep track of.
pub type Model {
  Model(current_stage: Int, score: Int)
}

fn init(_flags) -> Model {
  Model(current_stage: 1, score: 0)
}

// 2. THE ACTIONS (MSGS)
// Define all the possible things a player can do.
pub type Msg {
  PlayerChoseYes
  PlayerChoseNo
  ResetGame
}

// 3. THE UPDATE FUNCTION
// This handles your game logic and changes the state based on player actions.
fn update(model: Model, msg: Msg) -> Model {
  case msg {
    PlayerChoseYes -> Model(..model, current_stage: model.current_stage + 1, score: model.score + 10)
    PlayerChoseNo -> Model(..model, current_stage: model.current_stage + 1)
    ResetGame -> init(Nil)
  }
}

// 4. THE VIEW FUNCTION
// This renders the actual HTML elements onto the page.
fn view(model: Model) -> Element(Msg) {
  html.div([], [
    html.h1([], [html.text("My If Game")]),
    html.p([], [html.text("Stage: " <> int_to_string(model.current_stage))]),
    html.p([], [html.text("Score: " <> int_to_string(model.score))]),
    
    html.hr([]),
    
    html.div([], [
      html.button([element.on_click(PlayerChoseYes)], [html.text("Yes")]),
      html.button([element.on_click(PlayerChoseNo)], [html.text("No")]),
    ]),
    
    html.button([element.on_click(ResetGame)], [html.text("Reset Progress")]),
  ])
}

// Helper to safely convert Ints to Strings for rendering
import gleam/int
fn int_to_string(n: Int) -> String {
  int.to_string(n)
}

// 5. THE MAIN ENTRYPOINT
// Using component.sandbox to tie it all together perfectly.
pub fn main() {
  let app = component.sandbox(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}
