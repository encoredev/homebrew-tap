class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.1-beta.2"
    checksums = {
        "darwin_arm64" => "c062cafe50a9fa66830016dc2ccf65569078620ebebd65dadf46c59360194d9d",
        "darwin_amd64" => "67503556e9988af010a7c0424dd429ad72f42c688bee7e53108a7db7fc983d87",
        "linux_arm64"  => "37de81f46d2fbbaaf04156bf7d9a999b33d3f75bb0e572d350dfa4d9bca7f169",
        "linux_amd64"  => "7c288dbe82b7d040065979a69f0606f10f68f5f173fd3f4c1150135004eb7e53",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
