import gleam/int
import lustre
import lustre/element.{type Element}
import lustre/element/html
import lustre/event // 1. Fix: This is where on_click lives

// THE STATE (MODEL)
pub type Model {
  Model(current_stage: Int, score: Int)
}

fn init(_flags) -> Model {
  Model(current_stage: 1, score: 0)
}

// THE ACTIONS (MSGS)
pub type Msg {
  PlayerChoseYes
  PlayerChoseNo
  ResetGame
}

// THE UPDATE FUNCTION
fn update(model: Model, msg: Msg) -> Model {
  case msg {
    // 2. Fix: Fixed the redundant record update warning by using regular creation syntax
    PlayerChoseYes -> Model(current_stage: model.current_stage + 1, score: model.score + 10)
    PlayerChoseNo -> Model(current_stage: model.current_stage + 1, score: model.score)
    ResetGame -> init(Nil)
  }
}

// THE VIEW FUNCTION
fn view(model: Model) -> Element(Msg) {
  html.div([], [
    html.h1([], [html.text("My If Game")]),
    html.p([], [html.text("Stage: " <> int.to_string(model.current_stage))]),
    html.p([], [html.text("Score: " <> int.to_string(model.score))]),
    
    html.hr([]),
    
    html.div([], [
      // 3. Fix: Changed element.on_click to event.on_click
      html.button([event.on_click(PlayerChoseYes)], [html.text("Yes")]),
      html.button([event.on_click(PlayerChoseNo)], [html.text("No")]),
    ]),
    
    html.button([event.on_click(ResetGame)], [html.text("Reset Progress")]),
  ])
}

// THE MAIN ENTRYPOINT
pub fn main() {
  // 4. Fix: Changed component.sandbox back to lustre.sandbox
  let app = lustre.sandbox(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}
