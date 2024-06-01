class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.38.1"
    checksums = {
        "darwin_arm64" => "adfec592575a84bd04d07f3f5221e25743a539d63630b085ce7513ac648f1845",
        "darwin_amd64" => "abeae3629f2f3163bf2649725d57493177e938f2794bc0e5f25a440a18dcaa39",
        "linux_arm64"  => "a514c59151bde6d5e0575c66eaf8749edbddb5ecf654a5566424f73b80ce647f",
        "linux_amd64"  => "c3326316fabafc6722d4bb22e6e52010fc8a872512645836be86ec474345c8de",
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
