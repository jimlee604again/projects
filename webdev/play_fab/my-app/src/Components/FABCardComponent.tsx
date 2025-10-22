import { TurnStep } from "../Classes/TurnStep.ts";
import { useAttackingCard } from "../Contexts/AttackingCardContext.ts";
import { useOpponentAttack } from "../Contexts/OpponentAttackContext.ts";
import { useOpponentBlocks } from "../Contexts/OpponentBlocksContext.ts";
import { usePitchAmount } from "../Contexts/PitchAmountContext.ts";
import { usePitchCardsSelected } from "../Contexts/PitchCardsSelectedContext.ts";
import { usePlayerBlocks } from "../Contexts/PlayerBlocksContext.ts";
import { useSelectedCard } from "../Contexts/SelectedCardContext.ts"
import { useTurnStep } from "../Contexts/TurnStepContext.ts";

const FABCardComponent = (props) => {
    const card = props.card
    const innerComponent = (
        <div>
            <p><b>Cost:</b>{card.cost}</p>
            <p><b>Pitch:</b>{card.pitch}</p>
            <p><b>Attack:</b>{card.attack}</p>
            <p><b>Block:</b>{card.block}</p>
        </div>
    )

    const { turnStepValue } = useTurnStep();
    const { pitchCardsSelectedValue, setPitchCardsSelectedValue } = usePitchCardsSelected();
    const { attackingCardValue } = useAttackingCard();
    const { pitchAmountValue, setPitchAmountValue } = usePitchAmount();
    const { selectedCardValue, setSelectedCardValue } = useSelectedCard();
    const { opponentBlocksValue } = useOpponentBlocks();
    const { opponentAttackValue } = useOpponentAttack();
    const { playerBlocksValue, setPlayerBlocksValue } = usePlayerBlocks();

    const handleClick = () => {
        switch (turnStepValue) {
            case TurnStep.SELECT_ATTACK:
            case TurnStep.SELECT_ATTACK_ERROR: {
                if (card.playerOwned) {
                    setSelectedCardValue(card)
                }
                break;
            }
            case TurnStep.PITCH:
            case TurnStep.PITCH_ERROR:
                let nextPitchValue = new Set(pitchCardsSelectedValue);
                if (attackingCardValue && attackingCardValue.id != card.id && card.playerOwned) {
                    if (pitchCardsSelectedValue.has(card)) {
                        nextPitchValue.delete(card);
                        setPitchAmountValue(pitchAmountValue - card.pitch);
                    } else {
                        nextPitchValue.add(card);
                        setPitchAmountValue(pitchAmountValue + card.pitch);
                    }
                    setPitchCardsSelectedValue(nextPitchValue);
                }
                break;
            case TurnStep.PLAYER_ATTACK:
            case TurnStep.OPPONENT_BLOCK:
            case TurnStep.OPPONENT_TAKE_DAMAGE:
            case TurnStep.OPPONENT_START_TURN:
                break;
            case TurnStep.OPPONENT_ATTACK:
                let nextBlocksValue = new Set(playerBlocksValue);
                if (nextBlocksValue.has(card)) {
                    nextBlocksValue.delete(card);
                } else {
                    nextBlocksValue.add(card);
                }
                setPlayerBlocksValue(nextBlocksValue);
                break;
        }
    };

    let highlightColor;
    switch (turnStepValue) {
        case TurnStep.SELECT_ATTACK:
        case TurnStep.SELECT_ATTACK_ERROR:
            if (selectedCardValue === card) {
                highlightColor = "highlight_yellow";
            }
            break;
        case TurnStep.PITCH:
        case TurnStep.PITCH_ERROR:
            if (attackingCardValue && attackingCardValue === card) {
                highlightColor = "highlight_red";
            } else if (pitchCardsSelectedValue.has(card)) {
                highlightColor = "highlight_blue";
            }
            break;
        case TurnStep.PLAYER_ATTACK:
        case TurnStep.OPPONENT_BLOCK:
        case TurnStep.OPPONENT_TAKE_DAMAGE:
            if (attackingCardValue && attackingCardValue === card) {
                highlightColor = "highlight_red";
            }
            if (opponentBlocksValue.has(card)) {
                highlightColor = "highlight_gray"
            }
            break;
        case TurnStep.OPPONENT_START_TURN:
            break;
        case TurnStep.OPPONENT_ATTACK:
            if (opponentAttackValue && opponentAttackValue.attackingCard == card) {
                highlightColor = "highlight_red";
            }
            if (opponentAttackValue && opponentAttackValue.pitchedCards.has(card)) {
                highlightColor = "highlight_blue";
            }
            if (playerBlocksValue.has(card)) {
                highlightColor = "highlight_yellow";
            }
            break;
        case TurnStep.PLAYER_BLOCK:
        case TurnStep.PLAYER_TAKE_DAMAGE: {
            if (opponentAttackValue && opponentAttackValue.attackingCard == card) {
                highlightColor = "highlight_red";
            }
            if (opponentAttackValue && opponentAttackValue.pitchedCards.has(card)) {
                highlightColor = "highlight_blue";
            }
            if (playerBlocksValue.has(card)) {
                highlightColor = "highlight_gray";
            }
            break;
        }
        case TurnStep.PLAYER_TAKE_DAMAGE: {
            if (opponentAttackValue && opponentAttackValue.attackingCard == card) {
                highlightColor = "highlight_red";
            }
            if (opponentAttackValue && opponentAttackValue.pitchedCards.has(card)) {
                highlightColor = "highlight_blue";
            }
            if (playerBlocksValue.has(card)) {
                highlightColor = "highlight_gray";
            }
            break;
        }
        case TurnStep.PLAYER_TURN_START:
        case TurnStep.PLAYER_WIN:
        case TurnStep.PLAYER_LOSE:
        case TurnStep.UNKNOWN_STATE:
            break;
    }

    return (
        <button className={"FABCard center height_10vh" + (highlightColor ? " " + highlightColor : "")} onClick={handleClick}>
            {innerComponent}
        </button>
    );
}

export default FABCardComponent;
