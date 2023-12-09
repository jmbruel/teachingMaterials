package action;

import static org.junit.Assert.assertEquals;

import org.junit.Before;
import org.junit.Test;

import model.Piece;
import model.TypePiece;

public class FightTest {
	
	private static final Piece PIECE_SORCERESS = new Piece(TypePiece.SORCERESS);
	private static final Piece PIECE_KNIGHT = new Piece(TypePiece.KNIGHT);
	private static final Piece PIECE_DRAGON = new Piece(TypePiece.DRAGON);
	private static final Piece PIECE_TRAP = new Piece(TypePiece.TRAP);
	private static final Piece PIECE_DWARF = new Piece(TypePiece.DWARF);
	private static final Piece PIECE_TREASURE = new Piece(TypePiece.TREASURE);
	private static final Piece PIECE_SLAYER = new Piece(TypePiece.SLAYER);
	private Fight fight;
	
	@Before
	public void createFight() {
		fight = new Fight();
	}

	@Test
	public void fightSorceressVsKnight() {
		Piece resultat = fight.execute(PIECE_SORCERESS, PIECE_KNIGHT);

		assertEquals(PIECE_SORCERESS, resultat);
	}

	@Test
	public void fightKnightVsSorceress() {
		Piece resultat = fight.execute(PIECE_KNIGHT, PIECE_SORCERESS);

		assertEquals(PIECE_SORCERESS, resultat);
	}

	@Test
	public void fightDragonVsTrap() {
		Piece resultat = fight.execute(PIECE_DRAGON, PIECE_TRAP);

		assertEquals(PIECE_DRAGON, resultat);
	}

	@Test
	public void fightDwarfVsTrap() {
		Piece resultat = fight.execute(PIECE_DWARF, PIECE_TRAP);
		
		assertEquals(PIECE_TRAP, resultat);
	}

	@Test
	public void fightDwarfVsDwarf() {
		Piece resultat = fight.execute(PIECE_DWARF, PIECE_DWARF);
		
		assertEquals(null, resultat);
	}

	@Test
	public void fightDwarfVsTreasure() {
		Piece resultat = fight.execute(PIECE_DWARF, PIECE_TREASURE);
		
		assertEquals(PIECE_TREASURE, resultat);
	}

	@Test
	public void fightSlayerVsDragon() {
		Piece resultat = fight.execute(PIECE_SLAYER, PIECE_DRAGON);
		
		assertEquals(PIECE_DRAGON, resultat);
	}

	@Test
	public void fightDwarfVsDragon() {
		Piece resultat = fight.execute(PIECE_DWARF, PIECE_DRAGON);
		
		assertEquals(PIECE_DWARF, resultat);
	}
}
