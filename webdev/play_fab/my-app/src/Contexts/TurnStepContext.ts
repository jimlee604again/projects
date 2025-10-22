import { createContext, useContext } from "react";
import { TurnStep } from "../Classes/TurnStep.ts";

// TODO: Change to enum
export const TurnStepContext = createContext({turnStepValue: TurnStep.SELECT_ATTACK, setTurnStepValue:() => {}});

export const useTurnStep = () => useContext(TurnStepContext);