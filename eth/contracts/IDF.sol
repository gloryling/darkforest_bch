// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "./DFTypes.sol";
import "./libraries/LibStorage.sol";

interface IDF {
    function adminAddress() external view returns (address);

    function paused() external view returns (bool);

    function TOKEN_MINT_END_TIMESTAMP() external view returns (uint256);

    function getSnarkConstants() external pure returns (SnarkConstants memory);

    function getGameConstants() external pure returns (GameConstants memory);

    function planetLevelsCount() external view returns (uint256);

    function worldRadius() external view returns (uint256);

    function planetEventsCount() external view returns (uint256);

    function planetDefaultStats(uint256 level) external view returns (PlanetDefaultStats memory);

    function planetIds(uint256 idx) external view returns (uint256);

    function revealedPlanetIds(uint256 idx) external view returns (uint256);

    function playerIds(uint256 idx) external view returns (address);

    function planets(uint256 key) external view returns (Planet memory);

    function revealedCoords(uint256 key) external view returns (RevealedCoords memory);

    function planetsExtendedInfo(uint256 key) external view returns (PlanetExtendedInfo memory);

    function planetsExtendedInfo2(uint256 key) external view returns (PlanetExtendedInfo2 memory);

    function artifactIdToPlanetId(uint256 key) external view returns (uint256);

    function artifactIdToVoyageId(uint256 key) external view returns (uint256);

    function planetEvents(uint256 key) external view returns (PlanetEventMetadata[] memory);

    function players(address key) external view returns (Player memory);

    function planetArrivals(uint256 key) external view returns (ArrivalData memory);

    function planetArtifacts(uint256 key) external view returns (uint256[] memory);

    // ADDITIONAL UTILITY GETTERS

    function getNPlanets() external view returns (uint256);

    function getNRevealedPlanets() external view returns (uint256);

    function getNPlayers() external view returns (uint256);

    function getPlanetEventsCount(uint256 locationId) external view returns (uint256);

    function getPlanetEvent(uint256 locationId, uint256 idx) external view returns (PlanetEventMetadata memory);

    function getPlanetArrival(uint256 arrivalId) external view returns (ArrivalData memory);

    function getRevealedCoords(uint256 locationId) external view returns (RevealedCoords memory);

    function getUpgrades() external pure returns (Upgrade[4][3] memory);

    function getTypeWeights() external view returns (uint8[5][10][4] memory);

    function getPlayerSpaceJunkLimit(address playerId) external view returns (uint256);

    function getArtifactPointValues() external view returns (uint256[6] memory);

    function getRevealCooldown() external view returns (uint256);

    function getDefaultStats() external pure returns (PlanetDefaultStats[] memory);

    function getPlanetLevelThresholds() external view returns (uint256[] memory);

    function getCumulativeRarities() external view returns (uint256[] memory);

    function bulkGetPlanetIds(uint256 startIdx, uint256 endIdx) external view returns (uint256[] memory ret);

    function bulkGetRevealedPlanetIds(uint256 startIdx, uint256 endIdx) external view returns (uint256[] memory ret);

    function bulkGetPlanetsByIds(uint256[] calldata ids) external view returns (Planet[] memory ret);

    function bulkGetRevealedCoordsByIds(uint256[] calldata ids) external view returns (RevealedCoords[] memory ret);

    function bulkGetPlanetArrivalsByIds(uint256[] calldata ids) external view returns (ArrivalData[][] memory);

    function bulkGetPlanetsExtendedInfoByIds(uint256[] calldata ids) external view returns (PlanetExtendedInfo[] memory ret);

    function bulkGetPlanetsExtendedInfo2ByIds(uint256[] calldata ids) external view returns (PlanetExtendedInfo2[] memory ret);

    function bulkGetPlanetsDataByIds(uint256[] calldata ids) external view returns (PlanetData[] memory ret);

    function bulkGetVoyagesByIds(uint256[] calldata ids) external view returns (ArrivalData[] memory ret);

    function bulkGetPlanets(uint256 startIdx, uint256 endIdx) external view returns (Planet[] memory ret);

    function bulkGetPlanetsExtendedInfo(uint256 startIdx, uint256 endIdx) external view returns (PlanetExtendedInfo[] memory ret);

    function bulkGetPlayerIds(uint256 startIdx, uint256 endIdx) external view returns (address[] memory ret);

    function bulkGetPlayers(uint256 startIdx, uint256 endIdx) external view returns (Player[] memory ret);

    function getPlanetArrivals(uint256 _location) external view returns (ArrivalData[] memory ret);

    function bulkGetPlanetArrivals(uint256 startIdx, uint256 endIdx) external view returns (ArrivalData[][] memory);

    function getArtifactById(uint256 artifactId) external view returns (ArtifactWithMetadata memory ret);

    function getArtifactsOnPlanet(uint256 locationId) external view returns (ArtifactWithMetadata[] memory ret);

    function bulkGetPlanetArtifacts(uint256[] memory planetIds) external view returns (ArtifactWithMetadata[][] memory);

    function bulkGetArtifactsByIds(uint256[] memory ids) external view returns (ArtifactWithMetadata[] memory ret);

    /**
     * Get a group or artifacts based on their index, fetch all between startIdx & endIdx.
     Indexes are assigned to artifacts based on the order in which they are minted.
     * index 0 would be the first Artifact minted, etc.
     * @param startIdx index of the first element to get
     * @param endIdx index of the last element to get
     */
    function bulkGetArtifacts(uint256 startIdx, uint256 endIdx) external view returns (ArtifactWithMetadata[] memory ret);
    
    function pause() external;

    function unpause() external;

    /**
     * Only works for initialized planets.
     */
    function setOwner(uint256 planetId, address newOwner) external;

    function deductScore(address playerAddress, uint256 amount) external;

    function addScore(address playerAddress, uint256 amount) external;

    /**
     * Sets the owner of the given planet, even if it's not initialized (which is why
     * it requires the same snark arguments as DFCoreFacet#initializePlanet).
     */
    function safeSetOwner(address newOwner, uint256[2] memory _a, uint256[2][2] memory _b, uint256[2] memory _c, uint256[8] memory _input) external;

    function changeWorldRadiusMin(uint256 _newConstant) external;

    function adminSetWorldRadius(uint256 _newRadius) external;

    function changeLocationRevealCooldown(uint256 newCooldown) external;

    function withdraw() external;

    function setTokenMintEndTime(uint256 newTokenMintEndTime) external;

    function createPlanet(AdminCreatePlanetArgs memory args) external;

    function adminGiveSpaceShip(uint256 locationId, address owner, ArtifactType artifactType) external;

    function adminInitializePlanet(uint256 locationId, uint256 perlin) external;

    function setPlanetTransferEnabled(bool enabled) external;
}
