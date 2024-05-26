export class PriceOverride {
  id: number;
  workspaceId: number;
  itemId: number;
  price: number; // For the fixed price adjustments
  percentage: number; // For percentage adjustments to the price
}
