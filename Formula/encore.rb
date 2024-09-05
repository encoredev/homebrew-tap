class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.40.4"
    checksums = {
        "darwin_arm64" => "18e851b15cdbef3e785ef06846575e6526ab44d5b9d6ad1c454e64d9ecc9c0ef",
        "darwin_amd64" => "c4d9609299c882640bc40db42e67404c8a8398765c09f606402daf74bd010619",
        "linux_arm64"  => "c9f45f3d25bad55ef9251e4b21cb57b7f02533cffe4173ae98635e06d5a565d5",
        "linux_amd64"  => "b4db95794707503dc4fa0ed64503003943c76622c850d8f6f084336ac93f1073",
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
