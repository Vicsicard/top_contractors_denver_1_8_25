"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g = Object.create((typeof Iterator === "function" ? Iterator : Object).prototype);
    return g.next = verb(0), g["throw"] = verb(1), g["return"] = verb(2), typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateContractorData = updateContractorData;
var googlePlaces_1 = require("../src/utils/googlePlaces");
var promises_1 = __importDefault(require("fs/promises"));
var path_1 = __importDefault(require("path"));
// List of all trades we want to fetch data for
var TRADES = [
    'plumbers',
    'electricians',
    'hvac',
    'roofers',
    'painters',
    'carpenters',
    'landscapers',
    'bathroom-remodeling',
    'kitchen-remodeling',
    'home-remodeling',
    'windows',
    'flooring',
    'decks',
    'fencing',
    'masonry',
    'siding-and-gutters',
];
// Maximum number of contractors per category
var MAX_CONTRACTORS = 20;
function fetchTradeData(trade) {
    return __awaiter(this, void 0, void 0, function () {
        var response, limitedResults, sortedResults, error_1;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    console.log("Fetching data for ".concat(trade, "..."));
                    _a.label = 1;
                case 1:
                    _a.trys.push([1, 3, , 4]);
                    return [4 /*yield*/, (0, googlePlaces_1.searchPlaces)(trade, 'Denver, CO')];
                case 2:
                    response = _a.sent();
                    limitedResults = response.results.slice(0, MAX_CONTRACTORS);
                    sortedResults = limitedResults.sort(function (a, b) {
                        if (b.rating !== a.rating) {
                            return b.rating - a.rating;
                        }
                        return (b.user_ratings_total || 0) - (a.user_ratings_total || 0);
                    });
                    return [2 /*return*/, {
                            trade: trade,
                            lastUpdated: new Date().toISOString(),
                            results: sortedResults
                        }];
                case 3:
                    error_1 = _a.sent();
                    console.error("Error fetching data for ".concat(trade, ":"), error_1);
                    throw error_1;
                case 4: return [2 /*return*/];
            }
        });
    });
}
function saveDataToFile(data) {
    return __awaiter(this, void 0, void 0, function () {
        var dataDir, filePath, error_2;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    dataDir = path_1.default.join(process.cwd(), 'src/data/contractors');
                    filePath = path_1.default.join(dataDir, "".concat(data.trade, ".json"));
                    _a.label = 1;
                case 1:
                    _a.trys.push([1, 4, , 5]);
                    // Ensure the directory exists
                    return [4 /*yield*/, promises_1.default.mkdir(dataDir, { recursive: true })];
                case 2:
                    // Ensure the directory exists
                    _a.sent();
                    // Save the data
                    return [4 /*yield*/, promises_1.default.writeFile(filePath, JSON.stringify(data, null, 2), 'utf-8')];
                case 3:
                    // Save the data
                    _a.sent();
                    console.log("Data saved for ".concat(data.trade, " (").concat(data.results.length, " contractors)"));
                    return [3 /*break*/, 5];
                case 4:
                    error_2 = _a.sent();
                    console.error("Error saving data for ".concat(data.trade, ":"), error_2);
                    throw error_2;
                case 5: return [2 /*return*/];
            }
        });
    });
}
function updateContractorData() {
    return __awaiter(this, void 0, void 0, function () {
        var _i, TRADES_1, trade, data, error_3;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    console.log('Starting contractor data update...');
                    console.log("Will fetch up to ".concat(MAX_CONTRACTORS, " contractors per category"));
                    _i = 0, TRADES_1 = TRADES;
                    _a.label = 1;
                case 1:
                    if (!(_i < TRADES_1.length)) return [3 /*break*/, 8];
                    trade = TRADES_1[_i];
                    _a.label = 2;
                case 2:
                    _a.trys.push([2, 6, , 7]);
                    return [4 /*yield*/, fetchTradeData(trade)];
                case 3:
                    data = _a.sent();
                    return [4 /*yield*/, saveDataToFile(data)];
                case 4:
                    _a.sent();
                    // Add a delay between requests to avoid rate limiting
                    return [4 /*yield*/, new Promise(function (resolve) { return setTimeout(resolve, 2000); })];
                case 5:
                    // Add a delay between requests to avoid rate limiting
                    _a.sent();
                    return [3 /*break*/, 7];
                case 6:
                    error_3 = _a.sent();
                    console.error("Failed to update data for ".concat(trade, ":"), error_3);
                    // Continue with next trade even if one fails
                    return [3 /*break*/, 7];
                case 7:
                    _i++;
                    return [3 /*break*/, 1];
                case 8:
                    console.log('Contractor data update completed!');
                    return [2 /*return*/];
            }
        });
    });
}
// Only run if called directly (not imported)
if (require.main === module) {
    updateContractorData()
        .then(function () {
        console.log('Update completed successfully!');
        process.exit(0);
    })
        .catch(function (error) {
        console.error('Update failed:', error);
        process.exit(1);
    });
}
