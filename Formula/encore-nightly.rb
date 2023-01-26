class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230126"
    checksums = {
        "darwin_arm64" => "f4d065fb1bc4c3910f15e52288740c3ae7bcaac2be3832c202b5667491de5307",
        "darwin_amd64" => "5f954d3f431d00ede319a70c06fd1ea35f1b590be64c14ea1d7b08bb5667f17a",
        "linux_arm64"  => "0fe33d21fc0fd8dbce8fa791ebfd8ef3b14934d3c5660f1e89cd533c72ec6f45",
        "linux_amd64"  => "54567f47f41f49982250df17271c833896076bdf33aee34da13823b67cef28ef",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
