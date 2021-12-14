
TTree* getTree(TFile *file, TString treeName) {
    TTree *tree = nullptr;
    file->GetObject("ana/pandoraOutput", tree);
    return tree;
}
