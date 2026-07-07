package avatar.message;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import avatar.constants.NpcName;
import avatar.handler.NpcHandler;
import avatar.item.Item;
import avatar.model.Menu;
import avatar.model.Npc;
import avatar.network.Message;
import avatar.network.Session;
import avatar.service.FarmService;
import avatar.constants.Cmd;

public class FarmMsgHandler extends MessageHandler {

    private FarmService service;

    public FarmMsgHandler(Session client) {
        super(client);
        this.service = new FarmService(client);
    }

    @Override
    public void onMessage(Message mss) {
        if (mss == null) {
            return;
        }
        if (this.client.user == null) {
            return;
        }
        try {
            System.out.println("FarmMsgHandler: " + mss.getCommand());
            switch (mss.getCommand()) {
                case Cmd.SET_BIG_FARM: {
                    this.service.setBigFarm(mss);
                    break;
                }
                case Cmd.BUY_ITEM: {
                    this.service.Buy_item_farm(mss);
                    break;
                }
                case Cmd.BUY_ANIMAL: {
                    this.service.Buy_ANIMAL(mss);
                    break;
                }
                case Cmd.GET_BIG_FARM: {
                    this.service.getBigFarm(mss);
                    break;
                }
                case Cmd.GET_IMAGE_FARM: {
                    this.service.getImageData();
                    break;
                }
                case Cmd.GET_TREE_INFO: {
                    this.service.getTreeInfo(mss);
                    break;
                }
                case Cmd.INVENTORY: {
                    this.service.getInventory(mss);
                    break;
                }
                case Cmd.JOIN: {
                    this.service.joinFarm(mss);
                    break;
                }
                case Cmd.GET_IMG_FARM: {
                    try {
                        byte[] data = new byte[mss.reader().available()];
                        mss.reader().readFully(data);
                        StringBuilder sb = new StringBuilder();
                        for (byte b : data) {
                            sb.append(String.format("%02X ", b));
                        }
                        System.out.println("====== PACKET 82 RAW DATA ======");
                        System.out.println(sb.toString());
                        System.out.println("================================");
                        this.client.user.getAvatarService().serverDialog("Đã nhận packet 82, xem log VPS!");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                }
                case Cmd.REQUEST_SLOT: {
                    this.service.doRequestslot(mss);
                    break;
                }
                case Cmd.TREE_HARVEST: {
                    this.service.treeHarvest(mss);
                    break;
                }

                case Cmd.OPEN_LAND: {
                    this.service.openLand(mss);
                    break;
                }

                case Cmd.PLANT_SEED: {
                    this.service.plandSeed(mss);
                    break;
                }


                case Cmd.REQUEST_FRIENDLIST: {
                    this.service.serverDialog("Ăn trộm đang xây dựng");
                    break;
                }
                case Cmd.REQUEST_CHARGE_MONEY_INFO: {
                    this.service.serverDialog("Pay To Win hả");
                    break;
                }
                case Cmd.GET_CARD: {
                    this.service.sellFarmitm(this.client.user, mss);
                    break;
                }
                case Cmd.UPDATE_FARM_CATTLE: {
                    this.service.serverDialog("Mở rộng nông trại đang xây dựng vui lòng quay lại sau");
                    break;
                }
                case Cmd.UPDATE_FARM_FISH: {
                    this.service.serverDialog("Mở rộng nuôi cá đang xây dựng");
                    break;
                }
                case Cmd.STEAL: {
                    this.service.doSteal(this.client.user, mss);
                    break;
                }
                case Cmd.STEAL_INFO: {
                    this.service.serverDialog("Chức năng đang xây dựng");
                    break;
                }
                case Cmd.STEAL_STORE: {
                    this.service.serverDialog("Chức năng đang xây dựng");
                    break;
                }
                case Cmd.USING_ITEM: {
                    this.service.usingItem(this.client.user, mss);
                    break;
                }
                case Cmd.COOKING: {
                   // this.service.huy("Hủy Nấu Ăn Nhanh tutu");
                    break;
                }
                case Cmd.COMMUNICATE: {
                    // this.service.serverDialog("lãi buôn");
                    NpcHandler.handlerCommunicate(Npc.ID_ADD+NpcName.LAI_BUON,this.client.user);
                    break;
                }
                default:
                    super.onMessage(mss);
                    break;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}