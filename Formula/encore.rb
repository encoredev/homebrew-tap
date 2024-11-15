class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.12"
    checksums = {
        "darwin_arm64" => "6bf6cb8530c3e72ba9556653a0ea1ff7163dd7d333ab13455530f2e0a4c6ad21",
        "darwin_amd64" => "207f77161b1225474031dd1f78cdbb439c020ac0c291351ba5949ad4b3538f77",
        "linux_arm64"  => "ae57d444f84650ac56e9a888c4e0d23ed1981b996371ad41411e18e8061e0afd",
        "linux_amd64"  => "dca8f70d1f3688920cffbd0497c13639da86b2aafa8ab65ab5c9c261ae788532",
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
