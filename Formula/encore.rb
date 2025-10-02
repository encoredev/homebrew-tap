class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.4"
    checksums = {
        "darwin_arm64" => "84e1e3d5ae4dba7463ff78a2c434fdff1d38b05750eb51f88c257553e433d237",
        "darwin_amd64" => "de0855f0c03ba6f7cf0880bc7e5e8e9ceb88495ce09a079d015b23a7947cea1a",
        "linux_arm64"  => "63b83fec00f4427cbd18a3231792e568b607a901a5fca607a3196cac51e7691a",
        "linux_amd64"  => "933da8f083bc9e20eb604f4fd4f8f4e0c7b99f977969572ec46ab599db8dd584",
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
