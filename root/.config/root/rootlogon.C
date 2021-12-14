{
    TString homeDir = gSystem->Getenv("HOME");
    TString macroDir = homeDir + "/.config/root/";

    gROOT->LoadMacro(macroDir + "GetTree.C");
}
